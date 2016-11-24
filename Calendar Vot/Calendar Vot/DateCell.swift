//
//  DateCell.swift
//  Calendar Vot
//
//  Created by owner on 2016. 11. 17..
//  Copyright © 2016년 Neobono_Mac1. All rights reserved.
//

import UIKit

class DateCell: UITableViewCell {

   
    var startend:String = ""
    var datePickerView:UIView = UIView()
    var datePicker:UIDatePicker = UIDatePicker()
    var doneBtn = UIButton()
    
    
    
    @IBOutlet weak var startField: UITextField!
    @IBAction func startFieldEditing(_ sender: UITextField) {
        
        startend = "start"
        showDatePicker()
        sender.inputView = datePickerView
        doneBtn.addTarget(self, action: #selector(DateCell.doneButton), for: UIControlEvents.touchUpInside)
        datePicker.addTarget(self, action: #selector(DateCell.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    
    @IBOutlet weak var endField: UITextField!
    @IBAction func endFieldEditing(_ sender: UITextField) {
    
        startend = "end"
        showDatePicker()
        sender.inputView = datePickerView
        doneBtn.addTarget(self, action: #selector(DateCell.doneButton), for: UIControlEvents.touchUpInside)
        datePicker.addTarget(self, action: #selector(DateCell.datePickerValueChanged), for: UIControlEvents.valueChanged)

    }
    
    
    func showDatePicker(){
    
        datePickerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height:240))
        datePicker = UIDatePicker(frame: CGRect(x: 0, y: 40, width: self.frame.size.width , height: 200))
        datePicker.datePickerMode = UIDatePickerMode.dateAndTime
        datePicker.minuteInterval = 5
        datePickerView.addSubview(datePicker)
        
        doneBtn = UIButton(frame: CGRect(x: self.frame.size.width - 100,y: 0, width: 100, height: 50))
        doneBtn.setTitle("Done", for: UIControlState.normal)
        doneBtn.setTitle("Done", for: UIControlState.highlighted)
        doneBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        doneBtn.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        datePickerView.addSubview(doneBtn)


    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"

        if startend == "start"
        {
            startField.text = dateFormatter.string(from: sender.date)
        }
        else
        {
            endField.text = dateFormatter.string(from: sender.date)
        }
        
    }
    
    
    func doneButton(sender:UIButton)
    {
        if startend == "start"
        {
            startField.resignFirstResponder()
        }
        else
        {
            endField.resignFirstResponder()
        }
        


    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
