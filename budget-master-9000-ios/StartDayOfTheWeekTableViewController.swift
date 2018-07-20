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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors.background
        self.tableView.backgroundColor = Colors.background
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let currentDay = WeekStart.getWeekStart() - 1
        
        if(indexPath.row == currentDay) {
            highlightCell(row: currentDay)
        }
        
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        WeekStart.setWeekStart(day: indexPath.row + 1)
        clearCells()
        highlightCell(row: indexPath.row)
    }
    
    func highlightCell(row: Int){
        checks()[row]?.textColor = UIColor.green
    }
    
    func clearCells(){
        checks().forEach{ check in check.value.textColor = UIColor.white }
    }
    
    func checks() -> [Int: UILabel]{
        return [0: sundayLabel, 1: monLabel, 2: tuesLabel, 3: wedLabel, 4: thursLabel, 5: friLabel, 6: satLabel]
    }
}
