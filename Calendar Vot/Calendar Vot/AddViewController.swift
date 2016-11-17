//
//  AddViewController.swift
//  Calendar Vot
//
//  Created by owner on 2016. 11. 17..
//  Copyright © 2016년 Neobono_Mac1. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var AddVoteTable: UITableView!
    
    struct  Date {
        var Start:String
        var End:String
    }
    
    let sampleDate = [
        Date(Start:"20161111", End:"20161112"),
        Date(Start:"20161112", End:"20161113")
    ]
    
    let sampleLocation = [
        "A station", "B station", "C station" ]
    
    let options = ["복수 선택 허용","선택지 추가 허용","익명 투표", "마감기한 설정"]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AddVoteTable.dataSource = self
        AddVoteTable.delegate = self
      //  AddVoteTable.register(UITableViewCell.self, forCellReuseIdentifier: "OptionCell")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return 1
        }
        else if section == 1{
            return sampleDate.count
        }
        else if section == 2{
            return sampleLocation.count
        }
        else{
            return 4
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
  
        
        if indexPath.section == 0{

            let cell:TitleCell
            cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell") as! TitleCell
            cell.editTitle(text:"",placeholder:"enter title")
            return cell
      

        }
        else if indexPath.section == 1 {
            
            let cell:DateCell
            cell = tableView.dequeueReusableCell(withIdentifier: "DateCell") as! DateCell
            let date = sampleDate[indexPath.row]
            let datetext:String = date.Start + " - " + date.End
            cell.DateText.text = datetext
            return cell

        }
            
        else if indexPath.section == 2 {
            let cell:LocationCell
            cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell") as! LocationCell
            cell.LocationField.text = sampleLocation[indexPath.row]
            return cell

            
        }
        else{
            let cell:OptionCell
            cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell") as! OptionCell
            let option = options[indexPath.row]
            cell.OptionText.text = option
            
            return cell
        }
        
        
        
        
    }
    
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        
//        
//        if section == 0{
//            return "Title"
//        }
//        else if section == 1{
//
//            return "Date"
//        }
//        else if section == 2{
//            return "Location"
//        }
//        else{
//            return "Option"
//        }
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        var height : CGFloat
        
        height = 40
        
        return height
        
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var headerView : UIView?
        headerView = UIView(frame: CGRect(x:0, y:0, width:tableView.frame.size.width, height:30))
 
        
        let title = UILabel(frame: CGRect(x:10, y:10, width:100, height:30))
        title.font = UIFont.systemFont(ofSize: 15)
        title.textColor = UIColor.darkGray
        
        
        let addBtn = UIButton(type: UIButtonType.contactAdd)
        addBtn.backgroundColor = UIColor.clear
        addBtn.frame = CGRect(x:tableView.frame.size.width - 30, y:10, width:30, height:30)
        addBtn.addTarget(self, action: Selector(("buttonTouched:")), for: UIControlEvents.touchUpInside)
        
        if section == 0{
            
            title.text = "Title"
            
        
        }else if section == 1 {
            title.text = "Date"
            headerView?.addSubview(addBtn)

        
        }else if section == 2 {
            title.text = "Location"
            headerView?.addSubview(addBtn)

        
        }else{
            title.text = "Option"

        
        }
        
            headerView?.addSubview(title)
            return headerView
            
        
    }
    
    
    
    
    func buttonTouched(sender:UIButton!){
        
        print("diklik")
        
        
    }

    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
