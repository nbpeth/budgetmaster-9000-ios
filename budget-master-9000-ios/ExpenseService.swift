
import Foundation

class ExpenseService: ServiceDelgateable {
    
    func getExpensesFromServer() -> [Expense] {
        var page = 0
        var expenses = [Expense]()
        
        BudgetMasterService(delegate: self).fetchExpenses(page: page)
        
        return expenses
    }
    
    func success(response: [String : AnyObject]?) {
        
    }
    
    func fail(_ message: String) {
        
    }
    
}
