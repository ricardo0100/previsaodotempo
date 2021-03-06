//
//  ListOfCitiesTableViewController.swift
//  PrevisaoDoTempo
//
//  Created by Ricardo Gehrke Filho on 03/02/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import JGProgressHUD

class ListOfCitiesTableViewController: UITableViewController, UISearchBarDelegate, SearchCityDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var hud: JGProgressHUD?
    
    var controller = APIController()
    
    var cities: [City]? {
        
        didSet {
            tableView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller.searchCitydelegate = self
        searchBar.delegate = self
        
        hud = JGProgressHUD(style: .Dark)
        hud!.textLabel!.text = "Buscando"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        searchBar.resignFirstResponder()
        
        if segue.identifier == "Show Weather For City" {
            let vc = segue.destinationViewController as! CityWeatherViewController
            let index = tableView.indexPathForSelectedRow!.row
            let city = cities![index]
            vc.city = city
        }
    }
    
    func listCitiesWith(cities: [City]) {
        self.cities = cities
    }
    
    func hideActivityIndicator() {
        hud!.dismiss()
    }
    
    func showActivityIndicator() {
        hud!.showInView(self.view)
        searchBar.resignFirstResponder()
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
        self.controller.searchForCitiesWith(searchBar.text!)
        self.navigationController!.setNavigationBarHidden(false, animated: true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        searchBar.resignFirstResponder()
    }
    
}
