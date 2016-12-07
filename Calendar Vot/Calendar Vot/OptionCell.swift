//
//  OptionCell.swift
//  Calendar Vot
//
//  Created by owner on 2016. 11. 17..
//  Copyright © 2016년 Neobono_Mac1. All rights reserved.
//

import UIKit

class OptionCell: UITableViewCell {

    @IBOutlet weak var OptionText: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        //옵션 선택 시, checkmark on / off
        
        if (selected == true){
            if (self.accessoryType == UITableViewCellAccessoryType.none){
                self.accessoryType = UITableViewCellAccessoryType.checkmark
            }
            else
            {
                self.accessoryType = UITableViewCellAccessoryType.none
            }
        }

        // Configure the view for the selected state
    }

}
