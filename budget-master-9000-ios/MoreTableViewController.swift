import UIKit

class MoreTableViewController: BaseTableViewController {
    
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
}
