import RealmSwift
import Foundation

final class AppState {
    
    private init() { }
    
    static let shared = AppState()
    
    var user:User = User()
    
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
        guard let user = realm.objects(User.self).first else { return User() }
        return user
    }
    
}
