
import UIKit
import RealmSwift

class LoginViewController: UIViewController, ServiceDelgateable {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    @IBAction func loginButtonWasPressed(_ sender: AnyObject) {
        guard let username = usernameTextField.text, let password = passwordTextField.text else {
            fail("Fields cannot be blank")
            return
        }
        
        BudgetMasterService(delegate: self).authenticate(username:username,password:password)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        attemptLogin()

    }
    
    func attemptLogin(){
        let realm = try! Realm()
        guard let user = realm.objects(User.self).first,
            let token = user.authToken else {
                return
        }
        
        if(!token.isEmpty){
            navigateToMain(token)
        }
    }
    
    func fail(_ message:String){
        errorMessageLabel.text = message
    }
    
    func success(response: [String:AnyObject]){
        guard let token = response["token"] as? String else {
            self.fail("An Unknown Error Occurred")
            return
        }
        
        navigateToMain(token)
        
    }
    

    func navigateToMain(_ token: String){
        AppState.shared.setInitialAppState(token: token)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
        self.present(newViewController, animated: true, completion: nil)
    }
}
