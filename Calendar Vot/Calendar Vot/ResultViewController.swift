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

    @IBOutlet weak var ResultTable: UITableView!
    
    @IBAction func AddBtn(_ sender: UIBarButtonItem) {
        
        
    }
    
    
    static let storyboardIdentifier = "ResultView"

    @IBAction func DoneBtnPressed(_ sender: UIBarButtonItem) {
        
        //        // Create an Event Store instance
        //        let eventStore = EKEventStore();
        //        if let calendarForEvent = eventStore.calendar(withIdentifier: self.calendar.calendarIdentifier)
        //        {
        //            let newEvent = EKEvent(eventStore: eventStore)
        //
        //            newEvent.calendar = calendarForEvent
        //            newEvent.title = (voteData?.voteName)!
        //            newEvent.location = "여기"
        //            newEvent.startDate = Date.init()
        //            newEvent.endDate = Date.init(timeIntervalSinceNow: 60*60*24)
        //
        //            // Save the event using the Event Store instance
        //            do {
        //                try eventStore.save(newEvent, span: .thisEvent, commit: true)
        //                eventdelegate?.eventDidAdd()
        //
        //                self.dismiss(animated: true, completion: nil)
        //            } catch {
        //                let alert = UIAlertController(title: "Event could not save", message: (error as NSError).localizedDescription, preferredStyle: .alert)
        //                let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        //                alert.addAction(OKAction)
        //
        //                self.present(alert, animated: true, completion: nil)
        //            }
        //        }
    }
    
    var voteData:Vote?
    let votetitle:String = ""
    let dateFormatter = DateFormatter()
    
    
    
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
