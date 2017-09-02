
import UIKit


class BaseViewController: UIViewController, ServiceDelgateable {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors.background

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    func success(response: [String : AnyObject]?) {        
    }
    
    func fail(_ message: String) {
    }

}

class BaseTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors.background
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
}

class BasePagingViewController: UIPageViewController, ServiceDelgateable {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors.background
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    func success(response: [String : AnyObject]?) {
        
    }
    
    func fail(_ message: String) {
        print("FAIL \(message)")
    }
}
