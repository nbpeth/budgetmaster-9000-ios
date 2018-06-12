import UIKit
import Foundation

class ManageExpenseTypesTableViewController: UITableViewController {
    
    var expenseTypes: [ExpenseType] = [ExpenseType]()
    var expenseTypeService = ExpenseTypeService()
    
    @IBAction func addExpenseTypeButtonWasPressed(_ sender: Any) {
        expenseTypeService.createExpenseType(name: "New Category")
        loadExpenseTypes()
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = Colors.background

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadExpenseTypes()
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            let expenseType = expenseTypes[indexPath.row]
            expenseTypeService.deleteExpenseType(expenseType: expenseType)
            loadExpenseTypes()
            self.tableView.reloadData()
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    fileprivate func loadExpenseTypes(){
        expenseTypes = expenseTypeService.getAllTypes() ?? [ExpenseType]()

    }
}
