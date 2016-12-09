//
//  Vote.swift
//  Calendar Vot
//
//  Created by owner on 2016. 12. 8..
//  Copyright © 2016년 Neobono_Mac1. All rights reserved.
//

import Foundation
import Messages

// 몇 표 받았는지는 어떻게 하지..
struct MeetingDate
{
    static let key = "Date"
    var date:String = ""
    init(date:String){self.date = date}
    
}

struct MeetingLocation
{
    static let key = "Location"
    var location:String
    init(location:String){self.location = location}
}

struct MultiOption
{
    static let key = "MultiOption"
    var option:String?
}

struct AddItemOption
{
    static let key = "AddItemOption"
    var option:String
}

struct FinishOption
{
    static let key = "FinishOption"
    var option:String
}

struct CreateTime
{
    static let key = "CreateTime"
    var time:String
}

struct FinishTime
{
    static let key = "FinishTime"
    var time:String
}


class Vote{
    
    static let key = "name"
    
    var voteName : String = ""
    var dates:[MeetingDate] = []
    var dateData : [Date : Int]!
    var locations:[MeetingLocation] = []
    var locationData : [String : Int]!
    var multiSelect:MultiOption!
    var addItem:AddItemOption!
    var finishSet:FinishOption!
    var createTime:CreateTime?
    var finishTime:FinishTime?
    var isCreated:Bool{
        //투표이름이 저장되면, 이 투표가 생성되었음을 의미!
        return voteName != ""
    }
    
    let dateFormatter = DateFormatter()
    
    init()
    {
        self.voteName = ""
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        let current:NSDate = NSDate.init()
        createTime?.time = dateFormatter.string(from: current as Date)
        let finish:NSDate = NSDate.init(timeIntervalSinceNow: 60*60*24)
        finishTime?.time = dateFormatter.string(from: finish as Date)
    }
    
    func DateDataSetting()
    {
        for key in dateData.keys
        {
            var dateString : String
            var dateCountString : String
            
            dateString = dateFormatter.string(from: key)
            dateCountString = String(describing: dateData[key])
            
            dates.append(MeetingDate(date : dateString + "&" + dateCountString))
        }
    }
    
    func LocationDataSetting()
    {
        for key in locationData.keys
        {
            var locationString : String
            var locationCountString : String
            
            locationString = key
            locationCountString = String(describing: locationData[key])
            
            locations.append(MeetingLocation(location: locationString + "&" + locationCountString))
        }
    }
    
    func addDate(dateItem:MeetingDate)
    {
        self.dates.append(dateItem)
    }
    
    func addLocation(locationItem:MeetingLocation)
    {
        self.locations.append(locationItem)
    }
    

    func isFinished(now:Date) -> Bool
    {
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        if(dateFormatter.date(from: (finishTime!.time))! < now)
        {return true}
        else
        {return false}
    }
}

extension Vote
{
    var queryItems:[URLQueryItem]
    {
        var items = [URLQueryItem]()
        
        items.append(URLQueryItem(name: Vote.key, value: voteName))
        
        for date in dates
        {
            items.append(URLQueryItem(name: MeetingDate.key, value: date.date))
        }
        
        for location in locations
        {
            items.append(URLQueryItem(name: MeetingLocation.key, value: location.location))
        }
        
        return items
    }
    
    convenience init(queryItems : [URLQueryItem])
    {
        self.init()
        
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        for queryItem in queryItems
        {
            guard let value = queryItem.value else {continue}
            switch queryItem.name{
                
            case Vote.key:
                self.voteName = value
                
            case MeetingDate.key:
                let newDate:MeetingDate = MeetingDate.init(date: value)
                dates.append(newDate)
                
                let tempDateAndCount:[String] = value.components(separatedBy: "&")
                let tempDate:String = tempDateAndCount[0]
                if let tempCount:Int = Int(tempDateAndCount[1])
                {
                    dateData?[dateFormatter.date(from: tempDate)!] = tempCount
                }
                
            case MeetingLocation.key:
                let newLoca:MeetingLocation = MeetingLocation.init(location: value)
                locations.append(newLoca)
                let tempLocaAndCount:[String] = value.components(separatedBy: "&")
                let tempLoca:String = tempLocaAndCount[0]
                if let tempCount:Int = Int(tempLocaAndCount[1])
                {
                    locationData?[tempLoca] = tempCount
                }
            case MultiOption.key:
                multiSelect.option = value
                
            case AddItemOption.key:
                addItem.option = value
                
            case FinishOption.key:
                finishSet.option = value
                
            case CreateTime.key:
                createTime?.time = value
                
            case FinishTime.key:
                finishTime?.time = value
                
            default:
                break
            }
        }
    }
}

extension Vote
{
    convenience init?(message: MSMessage?) {
        guard let messageURL = message?.url else { return nil }
        guard let urlComponents = NSURLComponents(url: messageURL, resolvingAgainstBaseURL: false), let queryItems = urlComponents.queryItems else { return nil }
        self.init(queryItems: queryItems)
    }

}
