import UIKit


protocol AddViewControllerDelegate: class
{
    func addViewController(_ controller: AddViewController)
}

class AddViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    weak var delegate: AddViewControllerDelegate?
    @IBOutlet weak var AddVoteTable: UITableView!
    static let storyboardIdentifier = "AddView"
    
    @IBAction func voteNameChanged(_ sender: UITextField)
    {
        tempVoteName = sender.text!
    }
    
    
    @IBAction func DoneBtnPressed(_ sender: UIBarButtonItem)
    {
        if tempVoteName != ""
        {
            saveData(self.AddVoteTable)
        }
        else
        {
            let alert = UIAlertController(title: "투표 이름", message: "항목을 입력해주세요", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            self.present(alert, animated: false)
        }
    }
    
    
   // var voteData : Vote! = Vote.init()
    
    var voteData: Vote! = Vote.init()
    var dateCount : Int = 3
    var locationCount : Int = 3
    var optionCount: Int = 3
    var tempVoteName:String = ""
    let dateFormatter = DateFormatter()
    let options = ["복수 선택 허용","선택지 추가 허용", "마감기한 설정"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        AddVoteTable.dataSource = self
        AddVoteTable.delegate = self
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.dateFormat = "yyyy.MM.dd(E) a hh:mm"

    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0
        {
            return 1
        }
        else if section == 1
        {
            return dateCount
        }
        else if section == 2
        {
            return locationCount
        }
        else
        {
            return optionCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for:indexPath)
            
            cell.textLabel?.text = ""
            
            return cell
        }
        else if indexPath.section == 1
        {
            let cell:DateCell
            
            cell = tableView.dequeueReusableCell(withIdentifier: "DateCell") as! DateCell
            cell.index = indexPath.row
            
            return cell
            
        }
            
        else if indexPath.section == 2
        {
            let cell:LocationCell
            
            cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell") as! LocationCell
            cell.index = indexPath.row
            
            return cell
        }
        else
        {
            if( indexPath.row == 3)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell") as! DateCell
                
                return cell
                
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath)
                let option = options[indexPath.row]
                
                cell.textLabel?.text = option
                
                return cell
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        var height : CGFloat
        height = 40
        return height
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        var headerView : UIView?
        headerView = UIView(frame: CGRect(x:0, y:0, width:tableView.frame.size.width, height:30))
        
        let title = UILabel(frame: CGRect(x:10, y:10, width:100, height:30))
        title.font = UIFont.systemFont(ofSize: 15)
        title.textColor = UIColor.darkGray
        
        let addDateBtn = UIButton(type: UIButtonType.contactAdd)
        addDateBtn.backgroundColor = UIColor.clear
        addDateBtn.frame = CGRect(x:tableView.frame.size.width - 30, y:10, width:30, height:30)
        let addLocaBtn = UIButton(type: UIButtonType.contactAdd)
        addLocaBtn.backgroundColor = UIColor.clear
        addLocaBtn.frame = CGRect(x:tableView.frame.size.width - 30, y:10, width:30, height:30)
        
        addDateBtn.addTarget(self, action: #selector(self.addRow_date), for: UIControlEvents.touchUpInside)
        addLocaBtn.addTarget(self, action: #selector(self.addRow_place), for: UIControlEvents.touchUpInside)
        
        if section == 0
        {
            
            title.text = "Title"
        }
            
        else if section == 1
        {
            title.text = "Date"
            headerView?.addSubview(addDateBtn)
        }
            
        else if section == 2
        {
            title.text = "Location"
            headerView?.addSubview(addLocaBtn)
        }
            
        else
        {
            title.text = "Option"
        }
        
        headerView?.addSubview(title)
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if(indexPath.section == 3)
        {
            let cell = tableView.cellForRow(at: indexPath)!
            
            if (cell.accessoryType == UITableViewCellAccessoryType.none)
            {
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryType.none
            }
            
            if(indexPath.row == 2)
            {
                tableView.beginUpdates()
                
                if(cell.accessoryType == UITableViewCellAccessoryType.checkmark)
                {
                    optionCount += 1
                    tableView.insertRows(at: [IndexPath(row:3, section: 3)], with: .right)
                }
                else
                {
                    optionCount -= 1
                    tableView.deleteRows(at: [IndexPath(row:3, section: 3)], with: .left)
                }
                tableView.endUpdates()
                
            }
        }
    }
    
    func addRow_date( _: UIButton)
    {
        dateCount += 1
        AddVoteTable.reloadData()
        
    }
    
    func addRow_place(_:UIButton)
    {
        locationCount += 1
        AddVoteTable.reloadData()
    }
    
    func saveData(_ tableView: UITableView)
    {
        //1. 투표 이름
        voteData.voteName = tempVoteName

        for section in 0..<AddVoteTable.numberOfSections
        {
            for row in 0..<AddVoteTable.numberOfRows(inSection: section)
            {
                let indexPath = IndexPath(row: row, section: section)

                if(section == 1)
                {
                    let cell:DateCell = tableView.cellForRow(at: indexPath) as! DateCell
                    
                    if(cell.startField.text != "")
                    {
                        voteData.dateData.append((cell.startDate!, 0))
                    }
                    else {continue}
                }
                    
                else if(section == 2)
                {
                    let cell:LocationCell = tableView.cellForRow(at: indexPath) as! LocationCell
                    
                    if(cell.LocationField.text != "")
                    {
                        voteData.locationData.append((cell.LocationField!.text!, 0))
                    }
                }
                    
                else if(section == 3)
                {
                    //Vote 인스턴스에 옵션 정보 저장 .
                    let cell = tableView.cellForRow(at: indexPath)
                    
                    if(row == 0 && cell?.accessoryType == UITableViewCellAccessoryType.checkmark)
                    {
                        voteData.multiSelect.option = "true"
                    }
                    else if(row == 1 && cell?.accessoryType == UITableViewCellAccessoryType.checkmark)
                    {
                        voteData.addItem.option = "true"
                    }
                    else if(row == 2 && cell?.accessoryType == UITableViewCellAccessoryType.checkmark)
                    {
                        voteData.finishSet.option = "true"
                    }
                    
                    if(row == 3)
                    {
                        let cell:DateCell = tableView.cellForRow(at: indexPath) as! DateCell
                        
                        if(cell.startField.text != "")
                        {
                            voteData.finishTime.time = dateFormatter.string(from: cell.startDate!)
                        }
                    }
                    
                }
            }
        }
        voteData.created.isCreated = "true"
        
        voteData.DateDataSetting()
        voteData.LocationDataSetting()
        delegate?.addViewController(self)
    }
}
