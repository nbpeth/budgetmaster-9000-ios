import UIKit
import Foundation

class StartDayOfTheWeekTableViewController: UITableViewController {

    @IBOutlet weak var sundayLabel: UILabel!
    @IBOutlet weak var monLabel: UILabel!
    @IBOutlet weak var tuesLabel: UILabel!
    @IBOutlet weak var wedLabel: UILabel!
    @IBOutlet weak var thursLabel: UILabel!
    @IBOutlet weak var friLabel: UILabel!
    @IBOutlet weak var satLabel: UILabel!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        WeekStart.setWeekStart(day: indexPath.row + 1)
        checks().forEach{ check in check.value.textColor = UIColor.black }
        checks()[indexPath.row]?.textColor = UIColor.green
    }
    
    func checks() -> [Int: UILabel]{
        return [0: sundayLabel, 1: monLabel, 2: tuesLabel, 3: wedLabel, 4: thursLabel, 5: friLabel, 6: satLabel]
    }
}
