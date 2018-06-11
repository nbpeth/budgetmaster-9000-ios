
import UIKit

class SummaryViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var statsTableView: UITableView!
    var weeklyStats:[[String:AnyObject]] = [[:]]

    override func viewDidLoad() {
        super.viewDidLoad()
        statsTableView.delegate = self
        statsTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeklyStats.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "statsCell", for: indexPath) as? StatsTableViewCell
            else { fatalError() }
    
        let sum = weeklyStats[indexPath.row]["sum"] as? String
                
        cell.weekStartLabel.text = weeklyStats[indexPath.row]["weekStart"] as? String
        cell.weekEndLabel.text = weeklyStats[indexPath.row]["weekEnd"] as? String
        cell.sumLabel.text = weeklyStats[indexPath.row]["sum"] as? String ?? "0"
        
        guard let sumAsNumber = sum,
            let sumAsDouble = Double(sumAsNumber),
            let threshold = AppState.shared.user.spendingThreshold.value
        else {
            return cell
        }
        
        if(sumAsDouble <= Double(threshold)){
            cell.backgroundColor = UIColor.green
        }
        else{
            cell.backgroundColor = UIColor.red
        }
        
        return cell
    }
    
    override func success(response: Week) {
        self.statsTableView.reloadData()
    }
    
}
