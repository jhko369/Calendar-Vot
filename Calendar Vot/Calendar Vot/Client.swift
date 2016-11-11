//
//  Client.swift
//  Calendar Vot
//
//  Created by Neobono_Mac1 on 2016. 11. 11..
//  Copyright © 2016년 Neobono_Mac1. All rights reserved.
//

//
//  MakeOptionModule.swift
//  Project_Jwa_Team
//
//  Created by Neobono_Mac1 on 2016. 11. 10..
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
    var startDate : NSDate!
    var endDate : NSDate!
    
    init(startDate : NSDate, endDate : NSDate)
    {
        self.startDate = startDate
        self.endDate = endDate
    }
}

class MeetingPlace
{
    var placeName : String!
    
    init(placeName : String) {
        self.placeName = placeName
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
    
    init(name : VoteName, date : [Int : MeetingDate], place : [Int : MeetingPlace])
    {
        self.name = name
        self.date = date
        self.place = place
    }
}

var voteName : VoteName = VoteName.init(name: "에러 없음")
var meetingDate : [Int : MeetingDate] = [:]
var meetingPlace : [Int : MeetingPlace] = [:]

var vote : Vote = Vote.init(name: voteName, date: meetingDate, place: meetingPlace)








