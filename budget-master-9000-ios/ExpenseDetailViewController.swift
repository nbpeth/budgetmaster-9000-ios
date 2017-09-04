import UIKit
import Foundation

class ExpenseDetailViewController: BaseViewController {
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var detailsTitleLabel: UILabel!
    
    var expense: Expense?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabels()
       
    }
    
    fileprivate func configureLabels(){
        guard let cost = expense?.cost.value,
            let date = expense?.expenseDate,
            let location = expense?.location
            else { return }
        costLabel.text = String(describing: "$\(cost)")
        locationLabel.text = location
        dateLabel.text = date
        
        if expense?.expenseDescription != nil {
            detailsTitleLabel.isHidden = false
            descriptionLabel.isHidden = false
            descriptionLabel.text = expense?.expenseDescription ?? ""

        }
    }
    
}
