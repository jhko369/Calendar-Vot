

import UIKit

class NewDateCell: UITableViewCell
{
    var index : Int = 0
    var datePickerView:UIView = UIView() //datePicker, doneBtn 포함하는 inputView
    var datePicker:UIDatePicker = UIDatePicker()
    var doneBtn = UIButton()
    var startDate:Date?
    
    @IBOutlet weak var startField: UITextField!
    @IBAction func startFieldEditing(_ sender: UITextField) {
        
        
        showDatePicker()
        sender.inputView = datePickerView

    }
  
    @IBOutlet weak var countText: UILabel!
    
    
    
    func showDatePicker()
    {
        // 시작, 종료 시간을 나타내는 textfield 선택하면 나타나는 inputView 구성
        datePickerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height:240))
        datePicker = UIDatePicker(frame: CGRect(x: 0, y: 40, width: self.frame.size.width , height: 200))
        datePicker.datePickerMode = UIDatePickerMode.dateAndTime
        datePicker.minuteInterval = 5
        datePicker.locale = Locale(identifier: "ko_kr")
        datePickerView.addSubview(datePicker)
        
        doneBtn = UIButton(frame: CGRect(x: self.frame.size.width - 100,y: 0, width: 100, height: 50))
        doneBtn.setTitle("Done", for: UIControlState.normal)
        doneBtn.setTitle("Done", for: UIControlState.highlighted)
        doneBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        doneBtn.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        
        datePickerView.addSubview(doneBtn)
        
        doneBtn.addTarget(self, action: #selector(DateCell.doneButton), for: UIControlEvents.touchUpInside)
        datePicker.addTarget(self, action: #selector(DateCell.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    func datePickerValueChanged(sender:UIDatePicker)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.dateFormat = "yyyy.MM.dd(E) a hh:mm"
        startDate = sender.date
        startField.text = dateFormatter.string(from: sender.date)
        
    }
    
    func doneButton(sender:UIButton)
    {
        startField.resignFirstResponder()
        
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
}
