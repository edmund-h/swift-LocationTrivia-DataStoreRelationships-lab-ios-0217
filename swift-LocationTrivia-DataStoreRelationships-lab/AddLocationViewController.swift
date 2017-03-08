//
//  AddLocationViewController.swift
//  swift-LocationTrivia-DataStoreRelationships-lab
//
//  Created by Edmund Holderbaum on 3/7/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit

class AddLocationViewController: UIViewController{
    
    var store = LocationsDataStore.sharedInstance
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.cyan
    }
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var latitudeField: UITextField!
    @IBOutlet weak var longitudeField: UITextField!
    
    @IBAction func save(_ sender: UIButton) {
        guard let text = nameField.text,
            let latTxt = latitudeField.text,
            let longTxt = longitudeField.text else {return}
        guard !(text.isEmpty && latTxt.isEmpty && longTxt.isEmpty) else {return} //check text is in text fields
        guard let lat = Float(latTxt) , let long = Float(longTxt) else {return}  //check coords are floats
        store.addLocation(Location(name: text, latitude: lat, longitude: long))  //add the location to store
        
        cancel(sender) //calls the cancel button function when done
    }
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {})
    }
}
