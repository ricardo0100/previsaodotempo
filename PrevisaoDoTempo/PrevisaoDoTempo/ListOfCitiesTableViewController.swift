//
//  ListOfCitiesTableViewController.swift
//  PrevisaoDoTempo
//
//  Created by Ricardo Gehrke Filho on 03/02/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

class ListOfCitiesTableViewController: UITableViewController, SearchCityViewControllerDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var progressView: UIProgressView!
    
    var controller: APIController?
    var cities: [City]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller = APIController()
        controller!.delegate = self
        
        searchBar.delegate = self
    }
    
    func listCitiesWith(cities: [City]) {
        self.cities = cities
        self.tableView.reloadData()
    }
    
    func showProgressIndicator(progress: Float) {
        progressView.setProgress(progress, animated: false)
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
        let cell = tableView.dequeueReusableCellWithIdentifier("City Cell", forIndexPath: indexPath)
        let city = cities![indexPath.row]
        cell.textLabel!.text = city.name
        cell.detailTextLabel!.text = city.state
        return cell
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.controller!.searchForCitiesWith(searchBar.text!)
    }
    
}
