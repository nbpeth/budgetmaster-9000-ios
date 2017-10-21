
import UIKit

class BaseViewController: UIViewController, ServiceDelgateable {
    var expenseService: ExpenseService?
    
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

    func success(response: Week) {
    }
    
    func success(response: [Expense]) {
    }
    
    func fail(_ message: String) {
    }
}

class BaseTableViewController: UITableViewController, ServiceDelgateable {
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
    
    func success(response: Week) {
    }
    
    func success(response: [Expense]) {
    }
    
    func fail(_ message: String) {
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
    
    func success(response: Week) {
    }
    
    func success(response: [Expense]) {
    }
    
    func fail(_ message: String) {
        print("FAIL \(message)")
    }
}
