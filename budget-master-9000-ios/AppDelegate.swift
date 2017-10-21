import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let userId = "budgetmasteruser"
        
        Realm.Configuration.defaultConfiguration.deleteRealmIfMigrationNeeded = true
        
        let realm = try! Realm()
        let savedUser = realm.objects(User.self).filter{$0.name == userId}
        
        if(savedUser.count > 0){
            let currentUser = savedUser.first
            AppState.shared.user = currentUser ?? User()
            
        }
        else{
            let newUser = User()
            newUser.name = userId
            newUser.spendingThreshold.value = 300
            
            AppState.shared.user = newUser
            
            try! realm.write {
                realm.create(User.self, value: newUser, update: true)
            }
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {

        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        print("Realm File: \(String(describing: Realm.Configuration.defaultConfiguration.fileURL))")
        
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

