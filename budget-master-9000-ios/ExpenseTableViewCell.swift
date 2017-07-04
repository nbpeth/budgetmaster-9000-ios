
import UIKit

class ExpenseTableViewCell: UITableViewCell {

    @IBOutlet weak var expenseDateLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
