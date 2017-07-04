
import UIKit

class ExpensesViewController: UIViewController, ServiceDelgateable, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var expensesTableView: UITableView!
    var expenses:[Expense] = []
    var page:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expensesTableView.delegate = self
        expensesTableView.dataSource = self
        activityIndicator.startAnimating()
        
        BudgetMasterService(delegate: self).fetchExpenses(page: page)

    }
    
    func success(response: [String : AnyObject]) {
        activityIndicator.stopAnimating()
        
        let expenses = Expense.createFrom(dictionary: response)
        self.expenses += expenses
        self.expensesTableView.reloadData()
    }
    
    func fail(_ message: String) {
        
    }
   
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as? ExpenseTableViewCell
            
        else { fatalError() }
        
        loadNextPage(row: indexPath.row)
        
        let expense = expenses[indexPath.row]
        cell.locationLabel.text = expense.location
        cell.expenseDateLabel.text = expense.expenseDate
        cell.costLabel.text = String(describing: expense.cost!)
        
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.groupTableViewBackground : UIColor.white
        
        return cell
        
    }
    
    fileprivate func loadNextPage(row:Int){
        if(row >= self.expenses.count - 1 ){
            page += 1
            BudgetMasterService(delegate: self).fetchExpenses(page: page)
        }
    }
 

}
