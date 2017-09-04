
import UIKit

class ExpenseTableViewCell: UITableViewCell {

    @IBOutlet weak var expenseDateLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var expenseColorView: UIView!
    @IBOutlet weak var iconView: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    

}
