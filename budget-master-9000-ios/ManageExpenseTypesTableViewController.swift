import UIKit
import Foundation

class ManageExpenseTypesTableViewController: UITableViewController {
    
    var expenseTypes: [ExpenseType] = [ExpenseType]()
    var expenseTypeService = ExpenseTypeService()
    @IBOutlet weak var addNewExpenseTypeView: UIView!
    @IBOutlet weak var newCategoryNameField: UITextField!
    @IBOutlet weak var addButton: UIBarButtonItem!

    @IBAction func addExpenseTypeButtonWasPressed(_ sender: Any) {
        addButton.title = addNewExpenseTypeView.isHidden ? "Add" : "Close"
        addNewExpenseTypeView.isHidden = addNewExpenseTypeView.isHidden ? false : true
    }
    
    @IBAction func saveNewTypeButtonWasPressed(_ sender: Any) {
        expenseTypeService.createExpenseType(name: newCategoryNameField.text ?? "New Category")
        loadExpenseTypes()
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNewExpenseTypeView.isHidden = true
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
