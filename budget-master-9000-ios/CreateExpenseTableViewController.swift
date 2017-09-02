
import UIKit
import GoogleSignIn
import RealmSwift

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
    var expenseService: ExpenseService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.expenseTypePicker.dataSource = self
        self.expenseTypePicker.delegate = self
        self.locationTextField.delegate = self
        self.costTextField.delegate = self
        expenseService = ExpenseService(delegate: self)
        
        self.view.backgroundColor = Colors.background
        
        self.selectedExpenseType = ExpenseTypes.types[0]
        
        expenseTypeDetailLabel.text = ExpenseTypes.types[0]
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
        
        guard let email = currentUser?.profile?.email else { return }
        
        let expense = Expense(location, cost, expenseType, "", formatDate(expenseDatePicker.date), email)
        
        expenseService?.save(expense)
        
        resetFormFields()        
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
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ExpenseTypes.types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = ExpenseTypes.types[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!,NSForegroundColorAttributeName:UIColor.white])
        return myTitle
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        expenseTypeDetailLabel.text = ExpenseTypes.types[row]
        selectedExpenseType = ExpenseTypes.types[row]
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
        resetFormFields()
    }
    
    func resetFormFields(){
        submitButton.isHidden = false
        locationTextField.text = ""
        costTextField.text = ""
        hideTypePicker = true
        hideDatePicker = true
        selectedExpenseType = ExpenseTypes.types[0]
        expenseTypeDetailLabel.text = ExpenseTypes.types[0]
        self.tableView.reloadData()
    }
}
