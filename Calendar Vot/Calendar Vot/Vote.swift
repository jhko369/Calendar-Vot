//
//  Vote.swift
//  Calendar Vot
//
//  Created by owner on 2016. 12. 8..
//  Copyright © 2016년 Neobono_Mac1. All rights reserved.
//

import Foundation
import Messages

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
    var option:String
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

struct Created
{
    static let key = "Created"
    var isCreated:String
}

struct deviceID
{
    static let key = "deviceID"
    var uuID : String
}

class Vote
{
    static let key = "name"
    
    var voteName : String = ""
    var dates:[MeetingDate] = []
    var dateData : [(Date, Int)] = []
    var locations:[MeetingLocation] = []
    var locationData : [(String, Int)] = []
    var multiSelect:MultiOption
    var addItem:AddItemOption
    var finishSet:FinishOption
    var createTime:CreateTime
    var finishTime:FinishTime
    var created:Created
    var uuID:deviceID
    
    let dateFormatter = DateFormatter()
    
    init()
    {
        self.multiSelect = MultiOption(option:"false")
        self.addItem = AddItemOption(option:"false")
        self.finishSet = FinishOption(option:"false")
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.dateFormat = "yyyy.MM.dd(E) a hh:mm"
        
        let current:NSDate = NSDate.init()
        self.createTime = CreateTime(time: dateFormatter.string(from: current as Date))
        
        let finish:NSDate = NSDate.init(timeIntervalSinceNow: 60*60*24)
        self.finishTime = FinishTime(time: dateFormatter.string(from: finish as Date))
        self.created = Created(isCreated: "false")
        self.uuID.uuID = NSUUID.init().uuidString
    }
    
    func DateDataSetting()
    {
        dates = []
        
        for data in dateData
        {
            var dateString : String
            var dateCountString : String
            
            dateString = dateFormatter.string(from: data.0)
            dateCountString = String(describing: data.1)
            
            dates.append(MeetingDate(date : dateString + "&" + dateCountString))
        }
    }
    
    func LocationDataSetting()
    {
        locations = []
        
        for data in locationData
        {
            var locationString : String
            var locationCountString : String
            
            locationString = data.0
            locationCountString = String(describing: data.1)
            
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
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.dateFormat = "yyyy.MM.dd(E) a hh:mm"
        if(dateFormatter.date(from: (finishTime.time))! < now)
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
        //옵션 정보, created 추가
        items.append(URLQueryItem(name: MultiOption.key, value: multiSelect.option))
        items.append(URLQueryItem(name: AddItemOption.key, value: addItem.option))
        items.append(URLQueryItem(name: FinishOption.key, value: finishSet.option))
        items.append(URLQueryItem(name: Created.key, value: created.isCreated))

        return items
    }
    
    convenience init(queryItems : [URLQueryItem])
    {
        self.init()
        
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.dateFormat = "yyyy.MM.dd(E) a hh:mm"
        
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
                    dateData.append(dateFormatter.date(from: tempDate)!, tempCount)
                }
                
            case MeetingLocation.key:
                let newLoca:MeetingLocation = MeetingLocation.init(location: value)
                locations.append(newLoca)
                let tempLocaAndCount:[String] = value.components(separatedBy: "&")
                let tempLoca:String = tempLocaAndCount[0]
                if let tempCount:Int = Int(tempLocaAndCount[1])
                {
                    locationData.append(tempLoca, tempCount)
                }
            case MultiOption.key:
                multiSelect.option = value
                
            case AddItemOption.key:
                addItem.option = value
                
            case FinishOption.key:
                finishSet.option = value
                
            case CreateTime.key:
                createTime.time = value
                
            case FinishTime.key:
                finishTime.time = value
            case Created.key:
                created.isCreated = value
                
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


extension Vote {
    
    struct StickerProperties {
        static let size = CGSize(width: 300.0, height: 300.0)
        static let opaquePadding = CGSize(width: 60.0, height: 10.0)
    }
    
    func renderSticker(opaque: Bool) -> UIImage? {
        guard let listImage = renderList() else { return nil }
        
        // Determine the size to draw as a sticker.
        let outputSize: CGSize
        let listSize: CGSize
        
        if opaque {
            let scale = min((StickerProperties.size.width - StickerProperties.opaquePadding.width) / listImage.size.height,
                            (StickerProperties.size.height - StickerProperties.opaquePadding.height) / listImage.size.width)
            listSize = CGSize(width: listImage.size.width * scale, height: listImage.size.height * scale)
            outputSize = StickerProperties.size
        }
        else {
            let scale = StickerProperties.size.width / listImage.size.height
            listSize = CGSize(width: listImage.size.width * scale, height: listImage.size.height * scale)
            outputSize = listSize
        }
        
        let renderer = UIGraphicsImageRenderer(size: outputSize)
        let image = renderer.image { context in
            let backgroundColor: UIColor
            if opaque {
                backgroundColor = UIColor.white
            }
            else {
                backgroundColor = UIColor.clear
            }
            
            // Draw the background
            backgroundColor.setFill()
            context.fill(CGRect(origin: CGPoint.zero, size: StickerProperties.size))
            
            // Draw the scaled composited image.
            var drawRect = CGRect.zero
            drawRect.size = listSize
            drawRect.origin.x = (outputSize.width / 2.0) - (listSize.width / 2.0)
            drawRect.origin.y = (outputSize.height / 2.0) - (listSize.height / 2.0)
            
            listImage.draw(in: drawRect)
        }
        
        return image
    }
    
    private func renderList() -> UIImage? {
        let fontSize: CGFloat = 30
        let textColor: UIColor = UIColor.black
        let boldTextFont: UIFont = UIFont.boldSystemFont(ofSize: fontSize - 2)
        let textFont: UIFont = UIFont.systemFont(ofSize: fontSize - 4)
        let titleFontAttributes = [
            NSFontAttributeName: boldTextFont,
            NSForegroundColorAttributeName: textColor,
            ]
        let textFontAttributes = [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor,
            ]
        
        let imageSize = CGSize(width: 280, height: 280)
        let renderer = UIGraphicsImageRenderer(size: imageSize)
        let image = renderer.image { context in
            let backgroundColor = UIColor.lightGray
            backgroundColor.setFill()
            context.fill(CGRect(origin: CGPoint.zero, size: imageSize))
            
            var textHeight: CGFloat = fontSize
            
            let string = self.voteName as NSString
            string.draw(in: CGRect(x: 5, y: textHeight, width: 270, height: fontSize),withAttributes: titleFontAttributes)
            textHeight += fontSize
            for data in self.dateData {
                guard textHeight < 280 else {
                    break
                }
                let element = dateFormatter.string(from: data.0) as NSString
                element.draw(in: CGRect(x: 5, y: textHeight, width: 270, height: fontSize), withAttributes: textFontAttributes)
                textHeight += fontSize
            }
            for data in self.locationData {
                guard textHeight < 280 else {
                    break
                }
                let element = data.0 as NSString
                element.draw(in: CGRect(x: 5, y: textHeight, width: 270, height: fontSize), withAttributes: textFontAttributes)
                textHeight += fontSize
            }
        }
        return image
    }
}

