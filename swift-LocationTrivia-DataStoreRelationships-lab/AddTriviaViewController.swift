//
//  AddTriviaController.swift
//  swift-LocationTrivia-DataStoreRelationships-lab
//
//  Created by Edmund Holderbaum on 3/7/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit

class AddTriviaViewController: UIViewController {
    var location: String?
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.cyan
    }
    
    @IBOutlet weak var triviaText: UITextField!
    
    @IBAction func save (sender: UIButton) {
        let store = LocationsDataStore.sharedInstance
        guard let text = triviaText.text else {return}
        guard text != "" else {return}
        let myLoc = location ?? "nil"
        store.addTrivia(Trivium(content: text, likes: 0), forLocation: myLoc)
        cancel(sender: sender)
    }
    @IBAction func cancel (sender: UIButton) {
        self.dismiss(animated: true, completion: {})
    }
    
}//did not create a separate case because for debugging purposes i wanted the possibility of this class actually creating a new location and then for both tableviews to update to reflect this.

