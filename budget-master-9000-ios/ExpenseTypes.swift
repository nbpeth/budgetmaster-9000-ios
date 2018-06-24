
import Foundation
import RealmSwift

extension ExpenseType {
    static var defaultTypeNames: [String] {
        get {
            return ["Groceries","Food and Beverage","Miscellaneous","Entertainment","Health and Fitness","Household","Travel","Medical","Clothing"]
        }
    }
}

class ExpenseType: Object {
    dynamic var name:String?
    var threshold = RealmOptional<Double>()
    var id = RealmOptional<Int>()

    convenience init(name: String, threshold: Double){
        self.init()
        self.id = getNextId()
        self.name = name
        self.threshold = RealmOptional<Double>(threshold)
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func getNextId() -> RealmOptional<Int> {
        let realm = try! Realm()
        return RealmOptional<Int>((realm.objects(ExpenseType.self).max(ofProperty: "id") as Int? ?? 0) + 1)
    }
}

class ExpenseTypeService {

    func getAllTypes() -> [ExpenseType]? {
        let realm = try! Realm()
        
        return realm.objects(ExpenseType.self).map{$0}
    }
    
    func createExpenseType(name: String) -> ExpenseType {
        let realm = try! Realm()
        let expenseType = ExpenseType(name: name, threshold: 0.0)
        
        try! realm.write {
            realm.add(expenseType)
        }
        return expenseType
    }
    
    func deleteExpenseType(expenseType: ExpenseType) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(expenseType)
        }
    }
}
