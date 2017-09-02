
import Foundation
import RealmSwift
import GoogleSignIn

class Expense: Object {
    
    var id = RealmOptional<Int>()
    var cost = RealmOptional<Double>()
    dynamic var location:String?
    dynamic var expenseType:String?
    dynamic var expenseDescription:String?
    dynamic var expenseDate:String?
    dynamic var userId:String?
    
    convenience init(_ location:String, _ cost:Double, _ expenseType:String, _ expenseDescription:String, _ expenseDate:String, _ userId:String){
        self.init()
        self.id = getNextId()
        self.location = location
        self.cost = RealmOptional<Double>(cost)
        self.expenseType = expenseType
        self.expenseDescription = expenseDescription
        self.expenseDate = expenseDate
        self.userId = userId
    }
    
    convenience init(_ id: Int?, _ location:String, _ cost:Double, _ expenseType:String, _ expenseDescription:String, _ expenseDate:String, _ userId:String){
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
    
    static func createFrom(dictionary:[String:AnyObject]) -> [Expense]{
        
        guard let content = dictionary["content"] as? [[String:AnyObject]] else { return [] }
    
        let expenses:[Expense] = content.map { (expense) -> Expense in
            let id = expense["id"] as? Int ?? 0
            let location = expense["location"] as? String ?? ""
            let cost = expense["cost"] as? Double ?? 0.0
            let expenseType = expense["expenseType"] as? String ?? ""
            let expenseDescription = expense["description"] as? String ?? ""
            let expenseDate = expense["expenseDate"] as? String ?? ""
            let userId = expense["userId"] as? String ?? ""

            return Expense(id, location, cost, expenseType, expenseDescription, expenseDate, userId)

        }
        
        return expenses
    }
    
    func toDictionary() -> [String:AnyObject] {
        return [
            "location":self.location as AnyObject,
            "cost":self.cost as AnyObject,
            "expenseType":self.expenseType as AnyObject,
            "expenseDate":self.expenseDate as AnyObject
//            "userId":self.userId as AnyObject
        ]
    }

    //sort by id
    static func loadExpenses() -> [Expense]{
        let realm = try! Realm()
        return realm.objects(Expense.self).filter{$0.userId == AppState.shared.user.name}.map{$0}

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
