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
        calculateAggregates(week)
        self.tableView.reloadData()
    }
    
    func calculateAggregates(_ week: Week?){
        guard let expenses = week?.expenses else { return }
        
        aggs = expenses.reduce(into: [String:Double]()) { (res: inout [String:Double], next: Expense) in
            let cost = next.cost.value ?? 0
            let name = next.expenseType?.name ?? ""
            let currentValue = res[name] ?? 0
            res[name] = currentValue + cost
        }.sorted { $0.value > $1.value }
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
