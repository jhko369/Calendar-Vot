//
//  Client.swift
//  Calendar Vot
//
//  Created by Neobono_Mac1 on 2016. 11. 11..
//  Copyright © 2016년 Neobono_Mac1. All rights reserved.
//

import Foundation

class VoteName
{
    var name : String = ""
    
    init()
    {
        self.name = "투표"
    }
    
    init(name : String)
    {
        self.name = name
    }
}

class MeetingDate
{
    var startDate : Date?
    var endDate : Date?
    
    init()
    {
        self.startDate = nil
        self.endDate = nil
    }

}

class MeetingPlace
{
    var placeName : String?
    
    init()
    {
        self.placeName = nil
    }
}

class VoteOption
{
    
}

class Vote
{
    var name : VoteName
    var date : [Int : MeetingDate]
    var place : [Int : MeetingPlace]
    var multiSelect:Bool
    var addItem:Bool
    var finishTime:Bool
    
    init()
    {
        self.name = VoteName(name: "투표 이름")
        self.date = [:]
        self.place = [:]
        self.multiSelect = false
        self.addItem = false
        self.finishTime = false
        
        AddDate()
        AddPlace()
    }
    
    func AddDate()
    {
        var newDate : MeetingDate = MeetingDate()
        
        self.date[self.date.count] = newDate
    }
    
    func AddPlace()
    {
        var newPlace : MeetingPlace = MeetingPlace()
        
        self.place[self.place.count] = newPlace
    }
}

var voteName : VoteName = VoteName.init(name: "에러 없음")
var meetingDate : [Int : MeetingDate] = [:]
var meetingPlace : [Int : MeetingPlace] = [:]






