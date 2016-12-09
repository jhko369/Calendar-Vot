//
//  StartViewController.swift
//  Calendar Vot
//
//  Created by owner on 2016. 12. 5..
//  Copyright © 2016년 Neobono_Mac1. All rights reserved.
//

import UIKit

protocol StartViewControllerDelegate: class{
    func startViewControllerDidSelectAdd()
}

class StartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var StartTable: UITableView!
    
    static let storyboardIdentifier = "StartView"
    weak var delegate: StartViewControllerDelegate?
    
    let votes:[String] = ["아이디어 회의", "회식", "중간평가"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StartTable.dataSource = self
        StartTable.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){return 1}
        else {return votes.count}
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddVoteCell", for: indexPath)
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
            cell.textLabel?.text = votes[indexPath.row]
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        var height : CGFloat
        height = 25
        return height
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){return "add new vote"}
        else {return "history"}
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 0)
        {
            print("")
            delegate?.startViewControllerDidSelectAdd()
        }
    }

}
