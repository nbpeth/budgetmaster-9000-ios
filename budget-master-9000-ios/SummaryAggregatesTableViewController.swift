import UIKit
import Foundation

class SummaryAggregatesTableViewController: UITableViewController {
    var aggs = [(key: String, value: Double)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = Colors.background
    }
    
    func loadData(week: Week?){
        self.aggs = [(key: String, value: Double)]()
        self.aggs = ExpenseService.calculateAggregates(week)
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aggs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "aggregateCell") as? AggregatesTableViewCell else { return UITableViewCell() }
        
        cell.backgroundColor = indexPath.row % 2 == 0 ? Colors.cellBackground : Colors.cellBackgroundDark
        
        let currentExpense = aggs[indexPath.row]
        let cost = currentExpense.value
        let theme = ExpenseTypeTheme().themeFor(type: currentExpense.key, with: 0.8)
        cell.aggregateTypeIcon.image = theme.image
        cell.spendTtoalLabel.text = "$\(String(describing: cost))"
        cell.aggregateTypeLabel.text = currentExpense.key
        cell.spendTtoalLabel.textColor = UIColor.green
        return cell
    }
  
}
