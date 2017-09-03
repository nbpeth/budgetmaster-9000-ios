
import Foundation
import Alamofire
import GoogleSignIn
import RealmSwift

protocol ServiceDelgateable{
    func fail(_ message: String)
    func success(response:[String:AnyObject]?)
}

class BudgetMasterService {
    //extract contants
    let uri = "http://34.233.161.220:8080"

//    let uri = "http://localhost:8080"

    let currentUser = AppState.shared.user.name

    let headers: HTTPHeaders = ["Content-Type": "application/json","Authorization":AppState.shared.authToken]
    var delegate:ServiceDelgateable? = nil
    
    convenience init(delegate:ServiceDelgateable) {
        self.init()
        self.delegate = delegate
    }
    
    
    func submit(expense:Expense){
        let url = "\(uri)/expenses/\(String(describing: currentUser ?? ""))"
        let request = buildRequest(url: url, method: "POST", headers: headers, body: expense.toDictionary())
        
        makeRequest(request: request)
    }
    
    func delete(expense:Expense){
        guard let id = expense.id.value else { return }
        
        let url = "\(uri)/expenses/\(String(describing: currentUser ?? ""))/\(String(describing: id))"
        let request = buildRequest(url: url, method: "DELETE", headers: headers, body: expense.toDictionary())
        
        makeRequest(request: request)
    }
    
    func fetchExpenses(page:Int) {
        let url = "\(uri)/expenses/\(currentUser ?? "")?page=\(page)"
        let request = buildRequest(url: url, method: "GET", headers: headers, body: nil)
        
        makeRequest(request: request)
    }
    
    func fetchWeekData(weekOffSet: Int) {
        let url = "\(uri)/expenses/\(String(describing: currentUser ?? ""))/stats/week/\(weekOffSet)"
        let request = buildRequest(url: url, method: "GET", headers: headers, body: nil)
        
        makeRequest(request: request)
    }
    
    fileprivate func buildRequest(url:String, method:String, headers:HTTPHeaders, body:[String:AnyObject]?) -> URLRequest {
        let url = url
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(AppState.shared.authToken, forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 10
        
        if let requestBody = body {
            request.httpBody = try! JSONSerialization.data(withJSONObject: requestBody, options: [])
        }
        
        return request
    }
    
    fileprivate func makeRequest(request: URLRequest){
        guard let delegate = self.delegate else { return }
        
        Alamofire.request(request).responseJSON { response in
            if response.result.error != nil  {
                delegate.fail("")
                
            } else {
                guard let dictionary = response.result.value as? [String:AnyObject] else { return }
                delegate.success(response: dictionary)
            }
        }
    }
    

}
