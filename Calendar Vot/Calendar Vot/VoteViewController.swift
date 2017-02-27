//
//  VoteViewController.swift
//  Calendar Vot
//
//  Created by owner on 2016. 12. 1..
//  Copyright © 2016년 Neobono_Mac1. All rights reserved.
//

import UIKit
import EventKit


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
    
    @IBAction func FinishBtnPressed(_ sender: UIBarButtonItem) {
        
        finishVote = true
        saveData()
        
    }
    //-> Vote Data
    var voteData:Vote?
    let votetitle:String = ""
    var dateCellCount:Int = 0
    var locaCellCount:Int = 0
    let dateFormatter = DateFormatter()
    var lastSelect_Date:IndexPath?
    var lastSelect_Loca:IndexPath?
    var multi:String?
    var finishVote:Bool = false
    
    //-> User's Selection
    var selectDate : [Date] = []
    var selectLocation : [String] = []
    
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
        multi = voteData?.multiSelect.option
        
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
            return (voteData?.dateData.count)!
        case 2:
            return (voteData?.locationData.count)!
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 65.0
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
            if(indexPath.row < dateCellCount)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "VoteDateCell", for: indexPath)
                cell.textLabel?.text = dateFormatter.string(from: (voteData!.dateData[indexPath.row].0))
                cell.detailTextLabel?.text = "득표수: \(voteData!.dateData[indexPath.row].1)"
                return cell
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewDateCell") as! NewDateCell
                cell.startField.text = dateFormatter.string(from: (voteData!.dateData[indexPath.row].0))
                cell.countText.text = "득표수: \(voteData!.dateData[indexPath.row].1)"
                return cell
                
            }
        }
        else
        {
            
            if(indexPath.row < locaCellCount)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "VoteLocationCell", for: indexPath)
                cell.textLabel?.text = voteData!.locationData[indexPath.row].0
                cell.detailTextLabel?.text = "득표수: \(voteData!.locationData[indexPath.row].1)"
                return cell
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewLocationCell") as! NewLocationCell
                cell.locationField.text = voteData!.locationData[indexPath.row].0
                cell.countText.text = "득표수: \(voteData!.locationData[indexPath.row].1)"
                return cell
            }
            
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
        //VoteTable.beginUpdates()
        voteData?.dateData.append((Date.init(), 0))
        
        print(voteData?.dateData)
        VoteTable.reloadData()
    }
    
    func addRow_place(_:UIButton)
    {
        voteData?.locationData.append(("", 0))
        print(voteData?.locationData)
        VoteTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath)!
        if(indexPath.section == 1)
        {
            if(cell.accessoryType == UITableViewCellAccessoryType.none)
            {
                voteData?.dateData[indexPath.row].1 += 1
                cell.accessoryType = UITableViewCellAccessoryType.checkmark

                if(multi == "false")
                {
                    if let last = lastSelect_Date
                    {
                        let lastCell = tableView.cellForRow(at: last)
                        lastCell?.accessoryType = UITableViewCellAccessoryType.none
                        if((voteData?.dateData[last.row].1)! > 0)
                        { voteData?.dateData[last.row].1 -= 1}
                        
                //        selectDate.remove(at: last.row) // 선택 날짜 배열에서 삭제
                    }
                }
            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryType.none
                if((voteData?.dateData[indexPath.row].1)! > 0 )
                {voteData?.dateData[indexPath.row].1 -= 1}
                
               // selectDate.remove(at: indexPath.row) // 선택 날짜 배열에서 삭제
            }
            
            lastSelect_Date = indexPath
        }
        else if(indexPath.section == 2)
        {
            if(cell.accessoryType == UITableViewCellAccessoryType.none)
            {
                voteData?.locationData[indexPath.row].1 += 1
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
                selectLocation.append((voteData?.locationData[indexPath.row].0)!) // 선택 장소 배열에 추가
                
                if(multi == "false")
                {
                    if let last = lastSelect_Loca
                    {
                        let lastCell = tableView.cellForRow(at: last)
                        lastCell?.accessoryType = UITableViewCellAccessoryType.none
                        if((voteData?.locationData[last.row].1)! > 0)
                        {voteData?.locationData[last.row].1 -= 1}
                        
                      //  selectLocation.remove(at: last.row) // 선택 장소 배열에서 삭제
                    }
                }
            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryType.none
                if((voteData?.locationData[indexPath.row].1)! > 0)
                {voteData?.locationData[indexPath.row].1 -= 1}
                
                //selectLocation.remove(at: indexPath.row) // 선택 장소 배열에서 삭제
            }
            
            lastSelect_Loca = indexPath
        }
        
        tableView.reloadData()
    }
    
    func saveData()
    {
        voteData?.DateDataSetting()
        voteData?.LocationDataSetting()
        if(finishVote)
        {voteData?.created.isCreated = "finish"}

        
      //  voteData?.selectDate = selectDate
      //  voteData?.selectLocation = selectLocation
        voteData?.SelectDataSetting()
        
        delegate?.voteViewController(self)
    }
    
}
