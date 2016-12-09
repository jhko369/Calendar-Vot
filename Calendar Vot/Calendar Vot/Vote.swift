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
    
    var name : String = "title"
    var date : [MeetingDate] = []
    var dateData : [Date : Int]!
    var location : [MeetingLocation] = []
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
        //
    }
    
    func LocationDataSetting()
    {
        
    }
    
    func addDate(dateItem:MeetingDate)
    {
        self.date.append(dateItem)
    }
    
    func addLocation(locationItem:MeetingLocation)
    {
        self.location.append(locationItem)
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

extension Vote{
    
    // var queryItems:[URLQueryItem]
    
}
