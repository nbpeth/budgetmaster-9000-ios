
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
    
    func load() -> [Expense] {
        return [Expense]()
    }
    
    func syncWithServer() {
        //todo
    }
    
    
}
