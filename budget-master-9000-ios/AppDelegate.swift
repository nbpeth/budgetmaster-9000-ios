import UIKit
import RealmSwift
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return GIDSignIn.sharedInstance().handle(url,
                    sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                    annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {

        if (error == nil) {

            signIn.shouldFetchBasicProfile = true
            
            let userId = user.profile.email

            Realm.Configuration.defaultConfiguration.deleteRealmIfMigrationNeeded = true

            let realm = try! Realm()
            let savedUser = realm.objects(User.self).filter{$0.name == userId}
            
            if(savedUser.count > 0){
                let currentUser = savedUser.first
                AppState.shared.user = currentUser ?? User()
                AppState.shared.authToken = user.authentication.idToken

            }
            else{
                let newUser = User()
                newUser.name = userId
                newUser.spendingThreshold.value = 300
                newUser.authToken = user.authentication.idToken
                
                AppState.shared.user = newUser
                AppState.shared.authToken = user.authentication.idToken
                
                try! realm.write {
                    realm.create(User.self, value: newUser, update: true)
                }
            }
            
            
            //auto sign in is causing navigation bar to appear, fix me
            
            let rootViewController = self.window!.rootViewController as! UINavigationController
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = mainStoryboard.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
            rootViewController.pushViewController(mainViewController, animated: false)


            
        } else {
            print("\(error.localizedDescription)")
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        GIDSignIn.sharedInstance().clientID = "559785174037-t1mifh0tkkebo55e4v26fhiqtb70a84k.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self as GIDSignInDelegate

        
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

