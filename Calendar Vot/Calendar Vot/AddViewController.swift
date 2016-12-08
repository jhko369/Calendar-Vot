import UIKit

class AddViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var AddVoteTable: UITableView!
    
    static let storyboardIdentifier = "AddView"

    @IBAction func DoneBtnPressed(_ sender: UIBarButtonItem) {
        saveData()
        
    }
    
    
    var voteData : Vote = Vote() // 데이터 객체
    var dateCount : Int = 2
    var locationCount : Int = 2
    
    let dateFormatter = DateFormatter()
    let currentDate:Date = Date.init()
    let finishDate:Date = Date.init(timeIntervalSinceNow: 60*60*24)
    
    let options = ["복수 선택 허용","선택지 추가 허용", "마감기한 설정"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        AddVoteTable.dataSource = self
        AddVoteTable.delegate = self
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        
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
        else{
            return 3
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
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath)
            let option = options[indexPath.row]
            cell.textLabel?.text = option
            return cell
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 3)
        {
            let cell = tableView.cellForRow(at: indexPath)!
            if (cell.accessoryType == UITableViewCellAccessoryType.none){
                print("dd")
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
            }
            else
            {print("xx")
                cell.accessoryType = UITableViewCellAccessoryType.none
            }
            
            let tempindex = IndexPath(row: 2, section: 3) // 마감 기한 설정
            if(indexPath == tempindex)
            {
                
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
    
    func saveData()
    {
        //Vote 인스턴스에 투표 제목 저장
        //Vote 인스턴스에 옵션 상태 저장
        
        for section in 0..<AddVoteTable.numberOfSections {
            
            for row in 0..<AddVoteTable.numberOfRows(inSection: section) {
                
                let indexPath = IndexPath(row: row, section: section)
                if(section == 1)
                {
                    let cell:DateCell = AddVoteTable.cellForRow(at: indexPath) as! DateCell
                    if(cell.startField.text != nil && cell.endField.text != nil)
                    {
                        //Vote 인스턴스의 날짜 목록에 추가
                    }
                }
                else if(section == 2)
                {
                    let cell:LocationCell = AddVoteTable.cellForRow(at: indexPath) as! LocationCell
                    if(cell.LocationField.text != nil)
                    {
                        //Vote 인스턴스의 장소 목록에 추가
                    }
                }
                else if(section == 3)
                {
                    //Vote 인스턴스에 옵션 정보 저장 .
                    let cell = AddVoteTable.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath)
                    if(row == 0 && cell.accessoryType == UITableViewCellAccessoryType.checkmark)
                    {
                        voteData.multiSelect = true;
                    }
                    else if(row == 1 && cell.accessoryType == UITableViewCellAccessoryType.checkmark)
                    {
                        voteData.addItem = true;
                    }
                    else if(row == 2 && cell.accessoryType == UITableViewCellAccessoryType.checkmark)
                    {
                        voteData.finishTimeSet = true;
                    }
                }
            }
        }
    }
}
