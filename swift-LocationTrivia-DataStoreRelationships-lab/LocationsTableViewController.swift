//
//  LocationsTableViewController.swift
//  swift-LocationTrivia-DataStoreRelationships-lab
//
//  Created by Edmund Holderbaum on 3/6/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit


class LocationsViewController: UITableViewController, LocationStoreDelegate{
    
 let store = LocationsDataStore.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Locations"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.accessibilityLabel = title
        tableView.accessibilityIdentifier = title
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.accessibilityLabel = "Locations Table"
        tableView.backgroundColor = UIColor.cyan
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationCell
        cell.tag = indexPath.row
        print ("\(cell.tag) has tag")
        if let text = store.getLocationByIndex(index: cell.tag)?.name{
            print ("\(cell.tag) has loc, should have \(text)")
            cell.locationText = text
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return store.getLocationsCount()
    }
    
    func storeHasBeenChanged() {
        self.tableView.reloadData()
    }//conform to LocationAdderDelegate
             
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let name = segue.identifier else {return}
        switch name {
        case "TriviaTableSegue":
            let origin = sender as! UITableViewCell
            let destination = segue.destination as! TriviaTableViewController
            destination.location = store.getLocationByIndex(index: origin.tag)
        case "AddTriviaSegue":
            let destination = segue.destination as! AddLocationViewController
        default:
            return
        }
    }
}
