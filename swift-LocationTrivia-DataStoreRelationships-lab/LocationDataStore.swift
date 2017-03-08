//
//  LocationDataStore.swift
//  swift-LocationTrivia-DataStoreRelationships-lab
//
//  Created by Edmund Holderbaum on 3/6/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import Foundation
import UIKit

class LocationsDataStore {
    static let sharedInstance = LocationsDataStore()
    fileprivate var elements: [Location] = []
    private init() {generateStartingLocationsData()}
    
    func addLocation(_ loc: Location) {
        addLocations([loc])
    }
    func contains(_ myLoc: Location)-> Bool {
        return elements.contains(where: {$0.name == myLoc.name})
    }
    func getLocationByName(_ name: String)-> Location?{
        guard let indexToReturn = getIndexByName(name) else {return nil}
        return elements[indexToReturn]
    }
    func getLocationByIndex(index: Int)-> Location?{
        guard index < elements.count else {return nil}
        return elements[index]
    }
    func getLocationsCount()-> Int{
        return elements.count
    }
    fileprivate func getIndexByName(_ myLoc: String)->Int?{
        return elements.index(where: {$0.name == myLoc})
    }
    func addTrivia(_ triv: Trivium, forLocation myLoc: String){
        guard let num = getIndexByName(myLoc) else {return}
        elements[num].trivia.append(triv)
        notifyDelegate()
    }
    func likeTrivia(_ trivNum: Int, forLocation myLoc: String)-> Int? {
        guard let placeToUpdate = getIndexByName(myLoc) else {return nil}
        let something = elements[placeToUpdate].trivia
        something[trivNum].likes += 1
        notifyDelegate()
        return something[trivNum].likes
    }
    func addLocations( _ locs: [Location]) {
        locs.forEach({ (myLoc) in
            if !contains(myLoc) {elements.append(myLoc)}
        })
        notifyDelegate()
    }
    
    weak var delegate: LocationStoreDelegate?
    func notifyDelegate (){
        if let del = delegate {
            del.storeHasBeenChanged()
        }
        return()
    }
}

protocol LocationStoreDelegate: class {
    func storeHasBeenChanged() 
}


//MARK: Starting Trivia locations provided in lab
extension LocationsDataStore {
     fileprivate func generateStartingLocationsData() {
        
        let empireState = Location(name: "The Empire State Building", latitude: 40.7484, longitude: -73.9857)
        let trivium1A = Trivium(content: "1,454 Feet Tall", likes: 4)
        let trivium1B = Trivium(content: "Cost $24,718,000 to build", likes: 2)
        empireState.trivia.append(contentsOf:[trivium1A, trivium1B])
        
        let bowlingGreen = Location(name: "Bowling Green", latitude: 41.3739, longitude: -83.6508)
        let trivium2A = Trivium(content: "NYC's oldest park", likes: 8)
        let trivium2B = Trivium(content: "Made a park in 1733", likes: 2)
        let trivium2C = Trivium(content: "Charging Bull was created in 1989", likes: 0)
        bowlingGreen.trivia.append(contentsOf:[trivium2A, trivium2B, trivium2C])
        
        let ladyLiberty = Location(name: "Statue Of Liberty", latitude: 40.6892, longitude: -74.0444)
        let trivium3A = Trivium(content: "Gift from France", likes: 6)
        ladyLiberty.trivia.append(trivium3A)
        
        self.elements.append(contentsOf:[bowlingGreen, empireState, ladyLiberty])
    }
}
