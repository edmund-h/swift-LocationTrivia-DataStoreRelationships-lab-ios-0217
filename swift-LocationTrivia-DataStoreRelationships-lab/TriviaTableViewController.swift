//
//  LocationsTableViewController.swift
//  swift-LocationTrivia-DataStoreRelationships-lab
//
//  Created by Edmund Holderbaum on 3/6/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit


class TriviaTableViewController: UITableViewController, LocationStoreDelegate{
    var location: Location?=nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.cyan
    }
    
override func viewWillAppear(_ animated: Bool) {
        if let name = location?.name{
            tableView.accessibilityLabel = name
            tableView.accessibilityIdentifier = name
            self.title = name
        }
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let number = location?.trivia.count else {return 1}
        return number
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TriviaTableCell", for: indexPath) as! TriviumCell
        cell.tag = indexPath.row
        let thisTriv: Trivium = location?.trivia[cell.tag] ?? Trivium(content: "damnit", likes: -999)
        cell.triviumText = thisTriv.content
        cell.likesNum = thisTriv.likes
        cell.location = self.title
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier ==  "AddTriviaSegue" else {return}
        let destination = segue.destination as! AddTriviaViewController
        destination.location = self.title
    }
    
    func storeHasBeenChanged() {
        self.tableView.reloadData()
    }//conform to LocationAdderDelegate

}
