
import Foundation

class ExpenseService {
    var delegate:ServiceDelgateable? = nil
    
    init(delegate: ServiceDelgateable){
        self.delegate = delegate
    }
    
    func save(_ expense: Expense){
        Expense.save(expense)
    }
    
    func delete(_ expense: Expense){
        Expense.delete(expense)
    }
    
    func load() {
        guard let expenses = Expense.loadExpenses() else { delegate?.fail("could not load expenses"); return }
        delegate?.success(response: expenses)
    }
    
    func loadWeekData(offset:Int) {
        guard let week = Expense.loadWeekExpenses(offset:offset) else { delegate?.fail("could not load expenses"); return }
        delegate?.success(response: week)
    }
}
