//
//  ListOfCitiesTableViewController.swift
//  PrevisaoDoTempo
//
//  Created by Ricardo Gehrke Filho on 03/02/16.
//  Copyright © 2016 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import JGProgressHUD

class ListOfCitiesTableViewController: UITableViewController, SearchCityViewControllerDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var hud: JGProgressHUD?
    
    var controller: APIController?
    var cities: [City]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller = APIController()
        controller!.delegate = self
        
        hud = JGProgressHUD(style: .Dark)
        
        searchBar.delegate = self
    }
    
    func listCitiesWith(cities: [City]) {
        self.cities = cities
        self.tableView.reloadData()
    }
    
    func hideActivityIndicator() {
        hud!.dismiss()
    }
    
    func showActivityIndicator() {
        hud!.textLabel!.text = "Buscando"
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
        self.controller!.searchForCitiesWith(searchBar.text!)
        self.navigationController!.setNavigationBarHidden(false, animated: true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        searchBar.resignFirstResponder()
    }
}
