//
//  Client.swift
//  Calendar Vot
//
//  Created by Neobono_Mac1 on 2016. 11. 11..
//  Copyright © 2016년 Neobono_Mac1. All rights reserved.
//

import Foundation
import Messages


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
    var multiSelect:Bool // 다중선택 옵션
    var addItem:Bool // 선택지 추가 옵션
    var finishTimeSet:Bool // 마감시간 설정 옵션
    var createTime:Date //투표가 만들어진 시간
    var finishTime:Date //투표 마감시간(finishTimeSet == false -> default: createTime + 24시간)
    
    init()
    {
        self.name = VoteName(name: "투표 이름")
        self.date = [:]
        self.place = [:]
        self.multiSelect = false
        self.addItem = false
        self.finishTimeSet = false
        self.createTime = Date.init()
        self.finishTime = Date.init(timeIntervalSinceNow: 60*60*24)
        
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



//extension Vote{
//    init?(message: MSMessage?){
//        guard let messageURL = message?.url else { return nil }
//        guard let urlComponents = NSURLComponents(url: messageURL, resolvingAgainstBaseURL: false), let queryItems = urlComponents.queryItems else { return nil }
//
//        self.init(queryItems: queryItems)
//    }
//}


