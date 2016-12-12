//
//  VoteViewController.swift
//  Calendar Vot
//
//  Created by owner on 2016. 12. 1..
//  Copyright © 2016년 Neobono_Mac1. All rights reserved.
//

import UIKit
import EventKit


class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var voteName :String = ""
    var startdate : Date = Date()
    var location : String = ""
    
    @IBOutlet weak var ResultTable: UITableView!
    
    @IBAction func AddBtn(_ sender: UIBarButtonItem)
    {
        let eventStore = EKEventStore()
        
        let endDate = startdate.addingTimeInterval(60 * 60) // One hour
        
        if (EKEventStore.authorizationStatus(for: .event) != EKAuthorizationStatus.authorized)
        {
            eventStore.requestAccess(to: .event, completion: {
                granted, error in
                self.createEvent(eventStore, title: self.voteName, startDate: self.startdate, endDate: endDate, location: self.location)
            })
        } else {
            createEvent(eventStore, title: self.voteName, startDate: self.startdate, endDate: endDate, location: self.location)
        }
    }
    
    func createEvent(_ eventStore: EKEventStore, title: String, startDate: Date, endDate: Date, location: String)
    {
        let event = EKEvent(eventStore: eventStore)
        
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        event.location = location
        event.calendar = eventStore.defaultCalendarForNewEvents
        do {
            try eventStore.save(event, span: .thisEvent)
        } catch {
            print("Bad things happened")
        }
    }
    
    static let storyboardIdentifier = "ResultView"

    var voteData:Vote?
    let votetitle:String = ""
    let dateFormatter = DateFormatter()
    
    func SettingVoteResult()
    {
        self.voteName = (voteData?.voteName)!
        
        var tempDate : (Date, Int) = (Date(), 0)
        for date in (voteData?.dateData)!
        {
            if(date.1 > tempDate.1)
            {
                tempDate = date
            }
        }
        self.startdate = tempDate.0
        
        var tempLocation : (String, Int) = ("", 0)
        for location in (voteData?.locationData)!
        {
            if(location.1 > tempLocation.1)
            {
                tempLocation = location
            }
        }
        self.location = tempLocation.0
    }
    
    override func viewDidLoad()
    {
        //guard let voteData = voteData else { fatalError("만들어진 투표 없음") }
        
        super.viewDidLoad()
        ResultTable.dataSource = self
        ResultTable.delegate = self
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.dateFormat = "yyyy.MM.dd(E) a hh:mm"
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
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath)
            cell.textLabel?.text = voteData?.voteName
            return cell
        }
        else if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath)
            cell.textLabel?.text = dateFormatter.string(from: (voteData!.dateData[indexPath.row].0))
            cell.detailTextLabel?.text = "득표수: \(voteData!.dateData[indexPath.row].1)"
            return cell
                
            
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
            cell.textLabel?.text = voteData!.locationData[indexPath.row].0
            cell.detailTextLabel?.text = "득표수: \(voteData!.locationData[indexPath.row].1)"
            return cell
            
            
        }
    }
    

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0
        {
            return "Title"
        }
        else if section == 1
        {
            return "Date"
        }
        else
        {
            return "Location"
        }
    }
    
}
