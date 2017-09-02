
import Foundation
import Alamofire
import GoogleSignIn

protocol ServiceDelgateable{
    func fail(_ message: String)
    func success(response:[String:AnyObject]?)
}

class BudgetMasterService {
    //extract contants to promotion levels
    
    let uri = "http://34.233.161.220:8080"
    let serverDownError = "Unable to retrieve data from server. Please try again later"

//    let uri = "http://localhost:8080"

    let currentUser = GIDSignIn.sharedInstance().currentUser.profile

    let headers: HTTPHeaders = ["Content-Type": "application/json","Authorization":AppState.shared.authToken]
    var delegate:ServiceDelgateable? = nil
    
    convenience init(delegate:ServiceDelgateable) {
        self.init()
        self.delegate = delegate
    }

    func submit(expense:Expense){
        guard let delegate = self.delegate else { return }
        
        let url = "\(uri)/expenses/\(String(describing: currentUser?.email ?? ""))"
        Alamofire.request(url, method: HTTPMethod.post, parameters: expense.toDictionary(), encoding: JSONEncoding.default ,headers: headers).responseJSON { response in
                if response.result.error != nil  {
                    delegate.fail("Submission Failed")
                    
                } else {
                    guard let dictionary = response.result.value as? [String:AnyObject] else { return }
                    delegate.success(response: dictionary)
                }
        }
    }
    
    func delete(expense:Expense){
        guard let delegate = self.delegate,
            let id = expense.id
            else { return }
        
        let url = "\(uri)/expenses/\(String(describing: currentUser?.email ?? ""))/\(String(describing: id))"
        Alamofire.request(url, method: HTTPMethod.delete, parameters: expense.toDictionary() ,headers: headers).responseJSON { response in
            if response.result.error != nil  {
                delegate.fail("Delete Failed")
                
            } else {
                delegate.success(response: nil)
            }
        }
    }
    
    //network
    func fetchExpenses(page:Int) {
        guard let delegate = self.delegate else { return }
        let username = currentUser?.email
        let url = "\(uri)/expenses/\(username ?? "")?page=\(page)"

        Alamofire.request(url, method: HTTPMethod.get, headers: headers).responseJSON { response in
            if response.result.error != nil {
                delegate.fail(self.serverDownError)
            }
            else {
                guard let dictionary = response.result.value as? [String:AnyObject] else { return }
                delegate.success(response: dictionary)
            }
        }
    }
    
    func fetchStatistics() {
        guard let delegate = self.delegate else { return }
        let url = "\(uri)/expenses/\(currentUser?.email ?? "")/stats"
        
        Alamofire.request(url, method: HTTPMethod.get, headers: headers).responseJSON { response in
            if response.result.error != nil {
                delegate.fail(self.serverDownError)
            }
            else {
                guard let dictionary = response.result.value as? [String:AnyObject] else { return }
                delegate.success(response: dictionary)
            }
        }
    }
    
    func fetchWeekData(weekOffSet: Int) {
        guard let delegate = self.delegate else { return }
        let url = "\(uri)/expenses/\(String(describing: currentUser?.email ?? ""))/stats/week/\(weekOffSet)"
        
        Alamofire.request(url, method: HTTPMethod.get, headers: headers).responseJSON { response in
            if response.result.error != nil {
                delegate.fail(self.serverDownError)
            }
            else {
                guard let dictionary = response.result.value as? [String:AnyObject] else { return }
                delegate.success(response: dictionary)
            }
        }
    }

}
