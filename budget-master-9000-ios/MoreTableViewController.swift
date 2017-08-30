import UIKit
import GoogleSignIn

class MoreTableViewController: BaseTableViewController {
    @IBOutlet weak var signOutButton: UIButton!
    
    @IBOutlet weak var spendingThresholdLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors.background
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let user = AppState.shared.user
        spendingThresholdLabel.text = "$\(String(describing: user.spendingThreshold.value ?? 0))"
        
    }


    @IBAction func signoutButtonWasPressed(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "loginViewController") 
        self.present(newViewController, animated: true, completion: nil)
    }
    
}
