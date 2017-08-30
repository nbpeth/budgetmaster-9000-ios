
import Foundation
import RealmSwift

class User: Object {
    
    dynamic var name:String?
    dynamic var authToken:String?
    let spendingThreshold = RealmOptional<Int>()
    let income = RealmOptional<Double>()
    
    func buildUserFrom(dictionary:[String:Any]) -> User {
        let user = User()

        guard let username = dictionary["username"] as? String else { return user }
        
        user.name = username
        
        return user
    
    }
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
}
