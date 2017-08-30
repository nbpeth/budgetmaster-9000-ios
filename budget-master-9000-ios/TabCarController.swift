import UIKit

class TabCarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }


    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
}
