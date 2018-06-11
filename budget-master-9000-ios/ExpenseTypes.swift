
import Foundation
import RealmSwift

class ExpenseType: Object {
    dynamic var name:String?
    var threshold = RealmOptional<Double>()

    convenience init(name: String, threshold: Double){
        self.init()
        self.name = name
        self.threshold = RealmOptional<Double>(threshold)
    }
    
    override static func primaryKey() -> String? {
        return "name"
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
}
