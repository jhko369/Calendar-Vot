//
//  StartViewController.swift
//  Calendar Vot
//
//  Created by owner on 2016. 12. 5..
//  Copyright © 2016년 Neobono_Mac1. All rights reserved.
//

import UIKit

protocol StartViewControllerDelegate: class
{
    func startViewControllerDidSelectAdd()
}



class StartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var StartTable: UITableView!
    
    static let storyboardIdentifier = "StartView"
    weak var delegate: StartViewControllerDelegate?

    var votes:[Vote] = []
    var vote0:Vote!, vote1:Vote!, vote2:Vote!

    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        StartTable.dataSource = self
        StartTable.delegate = self
        
        print("Date  \(Date.init())")
        print("NS  \(NSDate.init())")
        loadVoteData()
    }
    
    func loadVoteData()
    {
        vote0 = Vote.init()
        vote0.voteName = "아이디어 회의"
        vote0.dateData = [(Date.init(), 0), (Date.init().addingTimeInterval(60*60*22),2), (Date.init().addingTimeInterval(60*60*42),1)]
        vote0.locationData = [("카페워크샵", 3),("도서관 세미나룸", 0)]
        vote0.multiSelect.option = "false"
        vote0.addItem.option = "false"
        vote0.finishSet.option = "false"
        vote0.created.isCreated = "true"
        vote0.DateDataSetting()
        vote0.LocationDataSetting()
       
        vote1 = Vote.init()
        vote1.voteName = "캡스톤 회식"
        vote1.dateData = [(Date.init(), 0), (Date.init().addingTimeInterval(60*60*80),1), (Date.init().addingTimeInterval(60*60*100),5)]
        vote1.locationData = [("족발", 2),("피자", 1),("치킨", 3)]
        vote1.multiSelect.option = "false"
        vote1.addItem.option = "false"
        vote1.finishSet.option = "false"
        vote1.created.isCreated = "true"
        vote1.DateDataSetting()
        vote1.LocationDataSetting()
        
        vote2 = Vote.init()
        vote2.voteName = "발표자료 준비"
        vote2.dateData = [ (Date.init().addingTimeInterval(60*60*30),2), (Date.init().addingTimeInterval(60*60*50),1)]
        vote2.locationData = [("각자 집에서", 2),("실습실", 1),("충무로 카페", 0)]
        vote2.multiSelect.option = "false"
        vote2.addItem.option = "false"
        vote2.finishSet.option = "false"
        vote2.created.isCreated = "true"
        vote2.DateDataSetting()
        vote2.LocationDataSetting()
        
        votes.append(vote0)
        votes.append(vote1)
        votes.append(vote2)
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(section == 0){return 1}
        else {return votes.count}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if(indexPath.section == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddVoteCell", for: indexPath)
            
            return cell
        }
            
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
            cell.textLabel?.text = votes[indexPath.row].voteName
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        var height : CGFloat
        height = 25
        
        return height
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if(section == 0)
        {
            return "add new vote"
        }
    
        else {return "history"}
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if(indexPath.section == 0)
        {
            print("")
            delegate?.startViewControllerDidSelectAdd()
        }
        else
        {
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "resultSegue"{
            if let destination = segue.destination as? ResultViewController , let selectedIndex = StartTable.indexPathForSelectedRow?.row {
                destination.voteData = votes[selectedIndex] as Vote
            }
        }
        
    }
}
