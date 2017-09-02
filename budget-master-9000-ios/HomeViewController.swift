
import UIKit
import GoogleSignIn

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var remainingMoneyLabel: UILabel!
    @IBOutlet weak var circleProgressView: CircleProgressView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var leftSwiper: UISwipeGestureRecognizer!
    @IBOutlet var rightSwiper: UISwipeGestureRecognizer!
    @IBOutlet weak var dateRangeLabel: UILabel!
    
    var page: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWelcomeLabel()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadStatsData()
    }
    
    @IBAction func screenWasTapped(_ sender: Any) {
        page = 0
        loadStatsData()
    }
    
    @IBAction func swipedLeft(_ sender: Any) {
        pageForward()
    }
    
    @IBAction func swipedRight(_ sender: Any) {
        pageBack()
    }
    
    override func success(response: [String : AnyObject]?) {
        if response != nil {
            activityIndicator.stopAnimating()
            configureRemainingMoneyLabel(response!)
        }
        else{
            fail("bad")
        }
        
        activityIndicator.stopAnimating()
        
        
    }
    
    fileprivate func pageForward(){
        if(page > 0){
            page = page - 1
            loadStatsData()
        }
    }
    
    fileprivate func pageBack(){
        page = page + 1
        loadStatsData()
    }
    
    fileprivate func loadStatsData(){
        
    }
//    fileprivate func loadStatsData(){
//        BudgetMasterService(delegate: self).fetchWeekData(weekOffSet: page)
//    }
    
    fileprivate func configureRemainingMoneyLabel(_ stats: [String:AnyObject]){
        guard let sum = stats["sum"] as? Double,
            let startDate = stats["weekStart"] as? String,
            let endDate = stats["weekEnd"] as? String,
            let threshold = spendingThreshold() else { return }
        let remainder = (threshold-sum)
        self.remainingMoneyLabel.text = "\(String(format: "$%.02f", locale: Locale.current, arguments: [remainder]))"
        self.remainingMoneyLabel.textColor = remainder >= 0 ? Colors.success : Colors.warn
        
        let dateText = page == 0 ? "This Week" : "\(startDate) - \(endDate)"
        
        self.dateRangeLabel.text = dateText
    
        loadProgressBar(sum:sum, threshold: threshold)

    }
    
    fileprivate func configureWelcomeLabel(){
        guard let name = GIDSignIn.sharedInstance().currentUser.profile.givenName else { return }
        
        self.welcomeLabel.text = "Welcome, \(String(describing: name)) !"
    }
    
    fileprivate func loadProgressBar(sum:Double, threshold:Double){
        let spend = sum / threshold
        let value = spend >= 1 ? 100 : 100 - spend
        circleProgressView.moveit(value: Float(value))
    }
    
    fileprivate func spendingThreshold() -> Double? {
        return Double(AppState.shared.user.spendingThreshold.value!)
    }


}
