import UIKit
import RealmSwift
import GoogleSignIn

class EditSpendingThresholdViewController: BaseViewController, UITextFieldDelegate {
    @IBOutlet weak var spendingThresholdTextField: UITextField!

    @IBAction func saveButtonWasPressed(_ sender: Any) {
        let realm = try! Realm()
        guard let spendingThreshold = spendingThresholdTextField.text,
            let letspendingThresholdAsDouble = Int(spendingThreshold) else { return }
        
        if(spendingThreshold.isEmpty){
            return
        }
        let user = AppState.shared.getUser()
        
        try! realm.write {
            user.spendingThreshold.value = letspendingThresholdAsDouble
            realm.create(User.self, value: user, update: true)
        }
        
        AppState.shared.updateUser(user)
        
        self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func cancelButtonWasPressed(_ sender: Any) {
        self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = AppState.shared.getUser()
        self.spendingThresholdTextField.delegate = self
        spendingThresholdTextField.text = String(describing: user.spendingThreshold.value ?? 0)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
