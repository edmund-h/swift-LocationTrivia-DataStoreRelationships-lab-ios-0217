//
//  LocationCell.swift
//  swift-LocationTrivia-DataStoreRelationships-lab
//
//  Created by Edmund Holderbaum on 3/7/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit

class LocationCell:UITableViewCell{
    
       
    var locationText: String?{
        didSet{
            locationLabel.text = locationText
        }
    }
    
    @IBOutlet weak var locationLabel: UILabel!

    
}
