//
//  VoteViewController.swift
//  Calendar Vot
//
//  Created by owner on 2016. 12. 1..
//  Copyright © 2016년 Neobono_Mac1. All rights reserved.
//

import UIKit


protocol VoteViewControllerDelegate: class {
    func VoteViewController(_ controller: VoteViewController)
}


class VoteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    
    @IBAction func DoneBtnPressed(_ sender: UIBarButtonItem) {
        saveData()
    }
  
    @IBOutlet weak var VoteTable: UITableView!
    weak var delegate: VoteViewControllerDelegate?

    static let storyboardIdentifier = "VoteView"
    
    var voteData:Vote?
    var multiSelect:Bool = false //다중선택 허용?
    var addItem:Bool = false //항목추가 허용?
    let votetitle:String = "팀프로젝트 회의"
    let startDate:Date = Date.init()
    let datelist:[String] = ["2016.12.04 20:00", "2016.12.06 20:00", "2016.12.09 16:00"]
    var dateCount:Int = 0
    let locationlist:[String] = ["충무로역 스타벅스", "신공학관 5127"]
    var locationCount:Int = 0
    let dateFormatter = DateFormatter()

    override func viewDidLoad()
    {
        //guard let voteData = voteData else { fatalError("만들어진 투표 없음") }
        
        super.viewDidLoad()
        
        VoteTable.dataSource = self
        VoteTable.delegate = self
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        dateCount = datelist.count
        locationCount = locationlist.count
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return dateCount
        case 2:
            return locationCount
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VoteTitleCell", for: indexPath)
            if(multiSelect)
            {cell.detailTextLabel?.text = "다중선택 가능"}
            else
            {cell.detailTextLabel?.text = ""}
            cell.textLabel?.text = votetitle
            return cell
        }
        else if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VoteDateCell", for: indexPath)
         //   let start:String = dateFormatter.string(from: startDate)
            cell.textLabel?.text = datelist[indexPath.row]
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VoteLocationCell", for: indexPath)
            // cell.textLabel?.text = voteData.place[indexPath.row]?.placeName
            cell.textLabel?.text = locationlist[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        var height : CGFloat
        height = 40
        return height
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
        
        if(addItem)
        { //항목 추가가 가능할 때만 타켓 생성
            addDateBtn.addTarget(self, action: #selector(self.addRow_date), for: UIControlEvents.touchUpInside)
            addLocaBtn.addTarget(self, action: #selector(self.addRow_place), for: UIControlEvents.touchUpInside)
        }
        else
        {//항목 추가가 불가능 하면 버튼 알파값을 0으로 변경
            addDateBtn.alpha = 0
            addLocaBtn.alpha = 0
        }
        
        if section == 0
        {title.text = "Title"}
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
        
        dateCount += 1
        VoteTable.reloadData()
    }
    func addRow_place(_:UIButton)
    {
        locationCount += 1
        VoteTable.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)!
        if(indexPath.section == 1 || indexPath.section == 2)
        {
            if (cell.accessoryType == UITableViewCellAccessoryType.none)
            {
                print("체크")
                /* multiSelect에 대한 부분. 섹션 내에서 선택된 셀 이외의 다른 셀을 none으로 바꿔야함*/
                if(multiSelect == false)
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
    
    }
    
    
}
