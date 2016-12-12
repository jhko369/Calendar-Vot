import UIKit

class NewLocationCell: UITableViewCell {
    
    var index : Int = 0
 
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var countText: UILabel!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        
        // Configure the view for the selected state
    }
    
}
