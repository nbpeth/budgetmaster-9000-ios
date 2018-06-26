
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
    
    static func calculateAggregates(_ week: Week?) -> [(key: String, value: Double)] {
        guard let expenses = week?.expenses else { return [(key: String, value: Double)]() }
        
        return expenses.reduce(into: [String:Double]()) { (res: inout [String:Double], next: Expense) in
            let cost = next.cost.value ?? 0
            let name = next.expenseType?.name ?? ""
            let currentValue = res[name] ?? 0
            res[name] = currentValue + cost
            }.sorted { $0.value > $1.value }
    }
    
}
