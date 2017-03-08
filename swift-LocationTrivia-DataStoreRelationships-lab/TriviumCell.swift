//
//  TriviumCell.swift
//  swift-LocationTrivia-DataStoreRelationships-lab
//
//  Created by Edmund Holderbaum on 3/7/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit

class TriviumCell:UITableViewCell{
    
    var location: String?
    
    var triviumText: String?{
        didSet{
            triviumLabel.text = triviumText
            triviumLabel.adjustsFontSizeToFitWidth = true
        }
    }
    var likesNum: Int?{
        didSet{
            if let likesNum = likesNum {likes.text = "\(likesNum)"}
        }
    }
    
    @IBOutlet weak var triviumLabel: UILabel!
    @IBOutlet weak var likes: UILabel!
    
    @IBAction func likeThis(_ sender: Any) {
        guard let location = location else {return}
        let meh = LocationsDataStore.sharedInstance
        likesNum = meh.likeTrivia(self.tag, forLocation: location)
    }
    
}

