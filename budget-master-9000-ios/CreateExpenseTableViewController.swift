
import UIKit
import GoogleSignIn

class CreateExpenseTableViewController: BaseTableViewController, UIPickerViewDelegate, UIPickerViewDataSource, ServiceDelgateable, UITextFieldDelegate {
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var costTextField: UITextField!
    @IBOutlet weak var expenseTypePicker: UIPickerView!
    @IBOutlet weak var expenseDatePicker: UIDatePicker!
    @IBOutlet weak var expenseTypePickerCell: UITableViewCell!
    @IBOutlet weak var expenseDatePickerCell: UITableViewCell!
    @IBOutlet weak var expenseDateDetailLabel: UILabel!
    @IBOutlet weak var expenseTypeDetailLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    let currentUser = GIDSignIn.sharedInstance().currentUser
    var selectedExpenseType:String?
    var hideTypePicker = true
    var hideDatePicker = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.expenseTypePicker.dataSource = self
        self.expenseTypePicker.delegate = self
        self.locationTextField.delegate = self
        self.costTextField.delegate = self
        
        self.view.backgroundColor = Colors.background
        
        self.selectedExpenseType = types[0]
        
        expenseTypeDetailLabel.text = types[0]
        expenseDatePicker.setValue(UIColor.white, forKeyPath: "textColor")

        setExpenseDateLabel()
    }
    
    @IBAction func submitButtonWasPressed(_ sender: Any) {
        guard let cost = Double(costTextField.text!),
            let location = locationTextField.text,
            let expenseType = selectedExpenseType
        else{
            return
        }
        
        submitButton.isHidden = true
        
        let expense = Expense()
        expense.userId = currentUser?.profile?.email
        expense.cost = cost
        expense.location = location
        expense.expenseType = expenseType
        expense.expenseDate = formatDate(expenseDatePicker.date)
        

        BudgetMasterService(delegate: self).submit(expense: expense)
        
    }
    
    func formatDate(_ date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let dateString = formatter.string(from: date)
        
        return dateString

    }
    
    func setExpenseDateLabel(){
        expenseDateDetailLabel.text = formatDate(expenseDatePicker.date)
    }
    
    @IBAction func expenseDatePickerDidChange(_ sender: Any) {
        setExpenseDateLabel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    let types = ["Clothing","Household Supplies","Groceries","Entertainment","Health and Fitness","Medical","Miscellaneous","Restaurant"]
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = types[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!,NSForegroundColorAttributeName:UIColor.white])
        return myTitle
    }
    
//    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return types[row]
//    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        expenseTypeDetailLabel.text = types[row]
        selectedExpenseType = types[row]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 1 && indexPath.row == 0){
            expenseDatePicker.isHidden = !expenseDatePicker.isHidden
            hideDatePicker = expenseDatePicker.isHidden
            self.tableView.reloadData()

        }
        else if(indexPath.section == 2 && indexPath.row == 0){
            expenseTypePicker.isHidden = !expenseTypePicker.isHidden
            hideTypePicker = expenseTypePicker.isHidden
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 1 && hideDatePicker == true){
            return 1
        }
        if(section == 1 && hideDatePicker == false){
            return 2
        }
        if(section == 2 && hideTypePicker == true){
            return 1
        }
        if(section == 2 && hideTypePicker == false){
            return 2
        }
        else if(section == 0) {
            return 2
        }
        return 1
    }
    
    func success(response: [String : AnyObject]?) {
        resetFormFields()
    }
    
    func fail(_ message: String) {
        print("FAIL!!!")

        resetFormFields()
    }
    
    func resetFormFields(){
        submitButton.isHidden = false
        locationTextField.text = ""
        costTextField.text = ""
        hideTypePicker = true
        hideDatePicker = true
        selectedExpenseType = types[0]
        expenseTypeDetailLabel.text = types[0]
        self.tableView.reloadData()
    }
}
