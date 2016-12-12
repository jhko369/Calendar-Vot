//
//  VoteViewController.swift
//  Calendar Vot
//
//  Created by owner on 2016. 12. 1..
//  Copyright © 2016년 Neobono_Mac1. All rights reserved.
//

import UIKit


protocol VoteViewControllerDelegate: class {
    func voteViewController(_ controller: VoteViewController)
}

class VoteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    weak var delegate: VoteViewControllerDelegate?
    static let storyboardIdentifier = "VoteView"
    @IBOutlet weak var VoteTable: UITableView!
    @IBAction func DoneBtnPressed(_ sender: UIBarButtonItem) {
        saveData()
    }
    var voteData:Vote?
    let votetitle:String = ""
    var dateCellCount:Int = 0
    var locaCellCount:Int = 0
    let dateFormatter = DateFormatter()
    
    

    override func viewDidLoad()
    {
        //guard let voteData = voteData else { fatalError("만들어진 투표 없음") }
        
        super.viewDidLoad()
        VoteTable.dataSource = self
        VoteTable.delegate = self
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.dateFormat = "yyyy.MM.dd(E) a hh:mm"
        dateCellCount = (voteData?.dates.count)!
        locaCellCount = (voteData?.locations.count)!
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch section
        {
        case 0:
            return 1
        case 1:
            return dateCellCount
        case 2:
            return locaCellCount
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VoteTitleCell", for: indexPath)
            if(voteData?.multiSelect.option == "true")
            {cell.detailTextLabel?.text = "다중선택 가능"}
            else
            {cell.detailTextLabel?.text = ""}
            cell.textLabel?.text = voteData?.voteName
            return cell
        }
        else if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VoteDateCell", for: indexPath)
            if(indexPath.row < (voteData?.dates.count)!)
            {
                cell.textLabel?.text = dateFormatter.string(from: (voteData!.dateData[indexPath.row].0))
                cell.detailTextLabel?.text = "\(voteData!.dateData[indexPath.row].1)"
            }
            else
            {
                cell.textLabel?.text = ""
                cell.detailTextLabel?.text = ""
            }
        
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VoteLocationCell", for: indexPath)
            if(indexPath.row < (voteData?.locations.count)!)
            {
                cell.textLabel?.text = voteData!.locationData[indexPath.row].0
                cell.detailTextLabel?.text = "\(voteData!.locationData[indexPath.row].1)"
            }
            else
            {
                cell.textLabel?.text = ""
                cell.detailTextLabel?.text = ""
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
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
        
        if(voteData?.addItem.option == "true")
        {
            //항목 추가가 가능할 때만 타켓 생성
            addDateBtn.addTarget(self, action: #selector(self.addRow_date), for: UIControlEvents.touchUpInside)
            addLocaBtn.addTarget(self, action: #selector(self.addRow_place), for: UIControlEvents.touchUpInside)
        }
            
        else
        {
            //항목 추가가 불가능 하면 버튼 알파값을 0으로 변경
            addDateBtn.alpha = 0
            addLocaBtn.alpha = 0
        }
        
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
        
        headerView?.addSubview(title)
     
        return headerView
    }
    
    func addRow_date(_: UIButton)
    {
       // var date : MeetingDate = MeetingDate()
       // voteData.date[voteData.date.count] = date
        
        dateCellCount += 1
        VoteTable.reloadData()
    }
    
    func addRow_place(_:UIButton)
    {
        locaCellCount += 1
        VoteTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath)!
        
        if(indexPath.section == 1 || indexPath.section == 2)
        {
            if (cell.accessoryType == UITableViewCellAccessoryType.none)
            {
                print("체크")
                /* multiSelect에 대한 부분. 섹션 내에서 선택된 셀 이외의 다른 셀을 none으로 바꿔야함*/
                if(voteData?.multiSelect.option == "false")
                {
                    for row in 0..<VoteTable.numberOfRows(inSection: indexPath.section)
                    {
                        let index = IndexPath(row: row, section: indexPath.section)
                        let cell = tableView.cellForRow(at: index)
                        if(cell?.accessoryType == UITableViewCellAccessoryType.checkmark)
                        {
                            print("체크해제")
                            cell?.accessoryType = UITableViewCellAccessoryType.none
                        }
                    }
                }
                
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
            }
                
            else
            {
                print("체크 해제")
                cell.accessoryType = UITableViewCellAccessoryType.none
            }
        }
    }
    
    func saveData()
    {
        for section in 0..<VoteTable.numberOfSections {
            for row in 0..<VoteTable.numberOfRows(inSection: section)
            {
                let indexPath = IndexPath(row: row, section: section)
                let cell = VoteTable.cellForRow(at: indexPath)
                
                if(section == 1)
                {
                    if(cell?.accessoryType == UITableViewCellAccessoryType.checkmark)
                    {
                        voteData?.dateData[row].1 += 1
                    }
                }
                
                if(section == 2)
                {
                    if(cell?.accessoryType == UITableViewCellAccessoryType.checkmark)
                    {
                        voteData?.locationData[row].1 += 1
                    }
                }
            }
        }
        
        voteData?.DateDataSetting()
        voteData?.LocationDataSetting()
        
        delegate?.voteViewController(self)
    }
}
