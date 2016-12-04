//
//  StartViewController.swift
//  Calendar Vot
//
//  Created by owner on 2016. 12. 4..
//  Copyright © 2016년 Neobono_Mac1. All rights reserved.
//

import UIKit

class StartViewController: UITableViewController {

    let votes:[String] = ["아이디어 회의", "회식", "중간평가"]
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){return 1}
        else {return votes.count}
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        var height : CGFloat
        height = 25
        return height
        
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){return "add new vote"}
        else {return "history"}
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
