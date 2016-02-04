//
//  ListOfCitiesTableViewController.swift
//  PrevisaoDoTempo
//
//  Created by Ricardo Gehrke Filho on 03/02/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

class ListOfCitiesTableViewController: UITableViewController, SearchCityViewControllerDelegate {
    
    var controller: APIController?
    var cities: [City]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller = APIController()
        controller!.delegate = self
        
        controller?.searchForCitiesWith("J")
    }
    
    func listCitiesWith(cities: [City]) {
        self.cities = cities
        tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = cities {
            return list.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "City cell")
        cell.textLabel!.text = cities![indexPath.row].name
        return cell
    }
}
