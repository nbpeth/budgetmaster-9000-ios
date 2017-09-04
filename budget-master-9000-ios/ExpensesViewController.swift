
import UIKit

class ExpensesViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var expensesTableView: UITableView!
    var refreshControl: UIRefreshControl!
    var expenses:[Expense] = []
    var page:Int = 0
    var totalElements:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expenseService = ExpenseService(delegate: self)
        expensesTableView.delegate = self
        expensesTableView.dataSource = self
        self.expensesTableView.backgroundColor = Colors.background
    
        configureRefreshControl()
        loadExpenses()
        
    }
    
    func loadExpenses() {
        activityIndicator.startAnimating()
        
        BudgetMasterService(delegate: self).fetchExpenses(page: page)

    }
    
    override func success(response: [String : AnyObject]?) {
        guard let dictionary = response,
            let elements = dictionary["totalElements"] as? Int else {
                return
        }
        
        activityIndicator.stopAnimating()
        self.refreshControl.endRefreshing()
        
        let expenses = Expense.createFrom(dictionary: dictionary)
        self.expenses += expenses
        self.totalElements = elements
        
        self.expensesTableView.reloadData()
    }
    
    override func fail(_ message: String) {
        self.expensesTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            let expense = expenses[indexPath.row]
            expenses.remove(at: indexPath.row)
//            expenseService?.delete(expense)
            BudgetMasterService(delegate:self).delete(expense: expense)
            self.expensesTableView.reloadData()
        }
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as? ExpenseTableViewCell
            
        else { fatalError() }
        
        loadNextPage(row: indexPath.row)
        
        return formatCell(cell, row: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let destination = storyboard.instantiateViewController(withIdentifier: "ExpenseDetailViewController") as? ExpenseDetailViewController {
            
            destination.expense = expenses[indexPath.row]
            self.navigationController?.pushViewController(destination, animated: true)
        }
    }

    fileprivate func formatCell(_ cell:ExpenseTableViewCell, row:Int) -> ExpenseTableViewCell{
        
        let expense = expenses[row]
        let expenseType = expense.expenseType ?? ""
        let cost = expense.cost.value ?? 0.00
        
        let theme = ExpenseTypeTheme().themeFor(type:expenseType, with: 0.8)
        
        cell.locationLabel.text = expense.location
        cell.expenseDateLabel.text = expense.expenseDate
        cell.costLabel.text = "$\(cost)"
        cell.expenseColorView.backgroundColor = theme.color
        cell.imageView?.image = theme.image!.withRenderingMode(.alwaysTemplate)
        cell.imageView?.tintColor = theme.color
        cell.imageView?.contentMode = .scaleAspectFit
        

        cell.backgroundColor = row % 2 == 0 ? Colors.cellBackground : Colors.cellBackgroundDark
        
        return cell

    }
    
    fileprivate func configureRefreshControl(){
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.tintColor = UIColor.black
        refreshControl.backgroundColor = UIColor.lightGray
        refreshControl.addTarget(self, action: #selector(ExpensesViewController.refresh(sender:)), for: .valueChanged)
        expensesTableView.addSubview(refreshControl)
    }

    @objc fileprivate func refresh(sender:AnyObject) {
        page = 0
        expenses = []
        self.expensesTableView.reloadData()
        loadExpenses()
    }
    
    fileprivate func loadNextPage(row:Int){
        if( row < totalElements - 1 && row >= self.expenses.count - 1){
            page += 1
            BudgetMasterService(delegate: self).fetchExpenses(page: page)
        }
    }
}
