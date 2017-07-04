
import Foundation
import Alamofire

protocol ServiceDelgateable{
    func fail(_ message: String)
    func success(response:[String:AnyObject])
}

class BudgetMasterService {
    let appState = AppState.shared
    
    let uri = "http://budgetmaster9000.herokuapp.com"
    var delegate:ServiceDelgateable? = nil
    
    convenience init(delegate:ServiceDelgateable) {
        self.init()
        self.delegate = delegate
    }
    
    func authenticate(username:String, password: String){
        guard let authenticationDelegate = self.delegate else { return }

        Alamofire.request(uri + "/auth", method: .post, parameters: ["username":username,"password":password], encoding: JSONEncoding.default)
            .responseJSON { response in
                if response.result.error != nil  {
                    authenticationDelegate.fail("Invalid username or password")
                    
                } else {
                    guard let dictionary = response.result.value as? [String:AnyObject] else { return }
                    authenticationDelegate.success(response: dictionary)
                }
        }
        
    }
    
    func fetchExpenses(page:Int) {
        guard let delegate = self.delegate else { return }
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization":appState.authToken
            
            ]
        Alamofire.request(uri + "/expenses?page=\(page)", method: HTTPMethod.get, headers: headers).responseJSON { response in
            if response.result.error != nil {
            }
            else {
                guard let dictionary = response.result.value as? [String:AnyObject] else { return }
                delegate.success(response: dictionary)
            }
        }
    }
}
