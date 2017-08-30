import RealmSwift
import Foundation
import GoogleSignIn

final class AppState {
    
    private init() { }
    
    static let shared = AppState()
    
    var user:User = User()
    var authToken:String = ""
    
    func saveUser(_ user:User){
        let realm = try! Realm()
        try! realm.write {
            realm.create(User.self, value: user, update: true)
        }
    }
    
    func updateUser(_ user: User){
        self.user = user
    }
    

    func getUser() -> User {
        let realm = try! Realm()
        
        guard let username = GIDSignIn.sharedInstance().currentUser.profile.email,
            let user = realm.objects(User.self).filter({ $0.name == username }).first else { return User() }
        
        
        return user
    }
    
}
