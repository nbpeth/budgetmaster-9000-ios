import RealmSwift
import Foundation

final class AppState {
    
    private init() { }
    
    // MARK: Shared Instance
    static let shared = AppState()
    
    var user:User = User()
    var authToken:String = ""
    
    func setInitialAppState(token:String){
        self.authToken = token
        let user = User()
        user.authToken = token
        user.name = "nmpeth"
        
        saveUser(user)
        
    }
    
    func saveUser(_ user:User){
        let realm = try! Realm()
        try! realm.write {
            realm.create(User.self, value: user, update: true)
        }
    }
    
//    func decode(_ token:String) -> [String:AnyObject]{
//        guard let payload = token.components(separatedBy: ".")[1] as? String,
//            let decodedData = NSData(base64Encoded: payload, options: NSData.Base64DecodingOptions(rawValue: 0)),
//            let decodedString = NSString(data: decodedData as Data, encoding: String.Encoding.utf8.rawValue) as String?,
//            let dictionary = decodedString as? [String:AnyObject]
//            else { return [:] }
//        return dictionary
//    }
}
