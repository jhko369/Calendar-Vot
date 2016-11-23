//
//  DateCell.swift
//  Calendar Vot
//
//  Created by owner on 2016. 11. 17..
//  Copyright © 2016년 Neobono_Mac1. All rights reserved.
//

import UIKit

class DateCell: UITableViewCell {


    @IBOutlet weak var startField: UITextField!
    
    @IBAction func startFieldEditing(_ sender: UITextField) {
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        datePickerView.locale = NSLocale(localeIdentifier: "en_GB") as Locale
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(DateCell.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        startField.text = dateFormatter.string(from: sender.date)
        
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
