
import Foundation

class Expense: NSObject {
    
    var id:Int?
    var cost:Double?
    var location:String?
    var expenseType:String?
    var expenseDescription:String?
    var expenseDate:String?
    
    override init(){
        super.init()
    }
    
    convenience init(_ id:Int, _ location:String, _ cost:Double, _ expenseType:String, _ expenseDescription:String, _ expenseDate:String){
        self.init()
        self.id = id
        self.location = location
        self.cost = cost
        self.expenseType = expenseType
        self.expenseDescription = expenseDescription
        self.expenseDate = expenseDate
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
            
            return Expense(id, location, cost, expenseType, expenseDescription, expenseDate)

        }
        
        return expenses
    }
    
//    override var description: String {
//        return self.id + " " + self.location + " " + self.cost + " " + self.expenseType + " " + self.expenseDate
//    }
}
