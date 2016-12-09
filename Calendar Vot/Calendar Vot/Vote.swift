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
}

struct MeetingLocation
{
    static let key = "Location"
    var location:String
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
    
    var voteName : String = "title"
    var dates : [MeetingDate] = []
    var dateData : [Date : Int]!
    var locations : [MeetingLocation] = []
    var locationData : [String : Int]!
    var multiSelect:MultiOption!
    var addItem:AddItemOption!
    var finishSet:FinishOption!
    var createTime:CreateTime!
    var finishTime:FinishTime!
    
    let dateFormatter = DateFormatter()
    
    init()
    {
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        multiSelect?.option = "false"
        addItem?.option = "false"
        finishSet?.option = "false"
        
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
        if(dateFormatter.date(from: finishTime.time)! < now)
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
        
        for location in  locations
        {
            items.append(URLQueryItem(name: MeetingLocation.key, value: location.location))
        }
        
        return items
    }
    
    init?(queryItems : [URLQueryItem])
    {
        for queryItem in queryItems
        {
            
        }
    }
}
