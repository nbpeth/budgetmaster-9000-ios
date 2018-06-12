import UIKit
import Foundation

class ManageExpenseTypesTableViewController: UITableViewController {
    
    var expenseTypes: [ExpenseType] = [ExpenseType]()
    var expenseTypeService = ExpenseTypeService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = Colors.background
        expenseTypes = expenseTypeService.getAllTypes() ?? [ExpenseType]()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseTypeCell") as? ExpenseTypeTableViewCell else { return UITableViewCell() }
        
        cell.nameLabel.text = expenseTypes[indexPath.row].name ?? ""

        return cell

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenseTypes.count
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
