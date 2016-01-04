//
//  LeftViewController.swift
//  4sqmap
//
//  Created by LostSeaWay on 12/31/2558 BE.
//  Copyright © 2558 LostSeaWay. All rights reserved.
//

import UIKit

class LeftMenuViewController: UITableViewController {

    @IBOutlet weak var text_search: UITextField!
    
    var data = [[FQPlace](),[FQPlace]()]
    var manager = FQManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        data[1] = manager.getNearbyPlaces()
        self.tableView.reloadData()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("placeCell", forIndexPath: indexPath)

            cell.textLabel?.text = data[indexPath.section][indexPath.row].name
            cell.detailTextLabel?.text = data[indexPath.section][indexPath.row].address
            return cell
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCellWithIdentifier("HeaderCell")
        
        if section == 0 {
            header?.textLabel!.text = "Search Result"
        }
        else{
            header?.textLabel!.text = "Nearby Places"
        }
        return header
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        (self.slideMenuController()?.rightViewController as! RightMenuViewController).place = self.data[indexPath.section][indexPath.row]
        
        if indexPath.section == 0{
            let mainNav = self.slideMenuController()?.mainViewController as! UINavigationController
            let rootView = mainNav.viewControllers.first as! MapViewController
            rootView.addPlaceAndMove(data[0][indexPath.row])
        }
        self.closeLeft()
        self.openRight()
    }
    
    
    @IBAction func searchAction(sender: AnyObject) {
        if !(text_search.text!.isEmpty){
            manager.searchPlace(text_search.text!){success, response in
                self.data[0].removeAll()
                self.data[0] = response
                self.tableView.reloadData()
            }
        }
    }
    
}
