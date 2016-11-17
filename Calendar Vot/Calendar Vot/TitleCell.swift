//
//  TitleCell.swift
//  Calendar Vot
//
//  Created by owner on 2016. 11. 17..
//  Copyright © 2016년 Neobono_Mac1. All rights reserved.
//

import UIKit

class TitleCell: UITableViewCell {

    @IBOutlet weak var titleField: UITextField!
    
    public func editTitle(text: String?, placeholder: String){
        titleField.text = text
        titleField.placeholder = placeholder
        titleField.accessibilityValue = text
        titleField.accessibilityLabel = placeholder
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
