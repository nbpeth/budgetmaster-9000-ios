
import UIKit

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
        expenseService = ExpenseService(delegate: self)
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
    
    override func fail(_ message: String){
        activityIndicator.stopAnimating()
        setRemainingMoneyLabelText(remainder: 0)
        self.dateRangeLabel.text = message
    }

    override func success(response: Week) {
        activityIndicator.stopAnimating()
        configureRemainingMoneyLabel(response)
        refreshAggregatesTable(response)
    }
    
    func refreshAggregatesTable(_ week: Week){
        guard let embeddedTable = self.childViewControllers[0] as? SummaryAggregatesTableViewController else { return }
        embeddedTable.loadData(week: week)
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
        expenseService?.loadWeekData(offset: page)
    }
    
    fileprivate func configureRemainingMoneyLabel(_ week: Week){
        let expenses = week.expenses
        
        let sum = expenses.reduce(0.0) {
            (r: Double, next: Expense) -> Double in
            return r + next.cost.value!
        }
        
        let threshold = spendingThreshold()
        let remainder = (threshold-sum)
        
        setRemainingMoneyLabelText(remainder: remainder)
        
        let startDate = Utils.formatDate(Calendar.current.date(byAdding: Calendar.Component.day, value: 1, to: week.startDate)!)
        let endDate = Utils.formatDate(week.endDate)
        let dateText = page == 0 ? "This Week" : "\(startDate) - \(endDate)"

        self.dateRangeLabel.text = dateText
    
        loadProgressBar(sum:sum, threshold: threshold)

    }
    
    fileprivate func setRemainingMoneyLabelText(remainder: Double){
        self.remainingMoneyLabel.text = "\(String(format: "$%.02f", locale: Locale.current, arguments: [remainder]))"
        self.remainingMoneyLabel.textColor = remainder >= 0 ? Colors.success : Colors.warn
    }
    
    
    fileprivate func loadProgressBar(sum:Double, threshold:Double){
        let spend = sum / threshold
        var value = 0.0
        
        if(spend > 0) {
            value = spend >= 1 ? 100 : 100 - spend
        }
        
        circleProgressView.moveit(Float(value))
        
    }
    
    fileprivate func spendingThreshold() -> Double {
        return Double(AppState.shared.user.spendingThreshold.value!)
    }
}
