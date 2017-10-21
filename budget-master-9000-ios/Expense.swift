
import Foundation
import RealmSwift

class Expense: Object {
    
    var id = RealmOptional<Int>()
    var cost = RealmOptional<Double>()
    dynamic var location:String?
    dynamic var expenseType:String?
    dynamic var expenseDescription:String?
    dynamic var expenseDate:Date?
    dynamic var userId:String?
    
    convenience init(_ location:String, _ cost:Double, _ expenseType:String, _ expenseDescription:String, _ expenseDate:Date, _ userId:String){
        self.init()
        self.id = getNextId()
        self.location = location
        self.cost = RealmOptional<Double>(cost)
        self.expenseType = expenseType
        self.expenseDescription = expenseDescription
        self.expenseDate = expenseDate
        self.userId = userId
    }
    
    convenience init(_ id: Int?, _ location:String, _ cost:Double, _ expenseType:String, _ expenseDescription:String, _ expenseDate:Date, _ userId:String){
        self.init()
        self.id = RealmOptional<Int>(id)
        self.location = location
        self.cost = RealmOptional<Double>(cost)
        self.expenseType = expenseType
        self.expenseDescription = expenseDescription
        self.expenseDate = expenseDate
        self.userId = userId
    }
    
    func getNextId() -> RealmOptional<Int> {
        let realm = try! Realm()
        return RealmOptional<Int>((realm.objects(Expense.self).max(ofProperty: "id") as Int? ?? 0) + 1)
    }

    static func loadExpenses() -> [Expense]? {
        let realm = try! Realm()
        let expenses:[Expense] = realm.objects(Expense.self).map{$0}
        
        return expenses
    }
    
    static func loadWeekExpenses(offset:Int) -> Week? {
        let realm = try! Realm()

        let week = Week(offset: offset)
        
        let expenses:[Expense] = realm.objects(Expense.self).filter{
            guard let date = $0.expenseDate else { return false }
                return (date >= week.startDate && date <= week.endDate)
            }
            .map{$0}
        
        week.expenses = expenses
        
        return week
    }

    static func save(_ expense: Expense) {
        let realm = try! Realm()
        try! realm.write {
            realm.create(Expense.self, value: expense, update: false)
        }
    }
    
    static func delete(_ expense: Expense){
        let realm = try! Realm()
        try! realm.write {
            realm.delete(expense)
        }
    }
    
}
