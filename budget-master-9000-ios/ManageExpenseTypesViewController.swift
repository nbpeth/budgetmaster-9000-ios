
import Foundation
import UIKit

class ManageExpenseTypesViewController: UIViewController {
    @IBOutlet weak var newTypeTextField: UITextField!
    @IBOutlet weak var embeddedTableViewController: UIView!
    var embeddedExpenseTypeTable: ManageExpenseTypesTableViewController?

    @IBAction func saveButtonWasPressed(_ sender: Any) {
        guard let expenseTypeTable = embeddedExpenseTypeTable else { return }
        let text = newTypeTextField.text ?? ""
        let newCategoryName = text.isEmpty ? "New Category" : text
        expenseTypeTable.expenseTypeService.createExpenseType(name: newCategoryName)
        expenseTypeTable.loadExpenseTypes()
        newTypeTextField.text = ""
        expenseTypeTable.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.destination {
            case let expenseTypeTable as ManageExpenseTypesTableViewController:
                self.embeddedExpenseTypeTable = expenseTypeTable
            
            default:
                break
        }
    }
    
}
