//
//  Checkpoint.swift
//  AmusementPark
//
//  Created by davidlaiymani on 01/04/2019.
//  Copyright © 2019 davidlaiymani. All rights reserved.
//

import Foundation

enum CheckpointType {
    case restrictedArea
    case skipTheLines
    case register
}

//A checkpoint has a type and allows to swipe a pass
protocol Checkpoint {
    var type: CheckpointType { get }
    
    func validateAccess(entrant: Entrant) -> Bool
}


// Checkpoint for restricted areas
class RestrictedAreaCheckpoint: Checkpoint {
    var type: CheckpointType
    var area: Area
    
    init(aera: Area) {
        self.area = aera
        self.type = .restrictedArea
    }
    
    // Access validation. For testing purpose this method prints some informations
    func validateAccess(entrant: Entrant) -> Bool {
        if entrant.areaAccess.contains(area) {
            print("\(entrant.stringForPersonalInformation()) - Authorized access to: \(area.rawValue)")
            return true
        } else {
            print("\(entrant.stringForPersonalInformation()) - You have not the access right to enter this area: \(area.rawValue)")
            return false
        }
    }
}

// Checkpoint for skip lines
class SkipTheLinesCheckpoint: Checkpoint {
    var type: CheckpointType
    
    init() {
        self.type = .skipTheLines
    }

    // Access validation. For testing purpose this method prints some informations
    func validateAccess(entrant: Entrant) -> Bool {
        if entrant.rideAccess.contains(.skipTheLines) {
            print("\(entrant.stringForPersonalInformation()) - You can skip the lines")
            return true
        } else {
            print("\(entrant.stringForPersonalInformation()) - You have not the access right to skip the line")
            return false
        }
    }
}

// Register checkpoint
class RegisterCheckPoint: Checkpoint {
    
    var type: CheckpointType
    
    init() {
        self.type = .register
    }
    
    // Access validation. For testing purpose this method prints some informations
    func validateAccess(entrant: Entrant) -> Bool {
        let discountOnFood = entrant.discountAccess[0].discount
        let discountOnMerchandise = entrant.discountAccess[1].discount
        if discountOnFood == 0.0 && discountOnMerchandise == 0.0 {
            print("\(entrant.stringForPersonalInformation()) - No discount")
            return false
        } else {
            let discountOnFood = entrant.discountAccess[0].discount
            let discountOnMerchandise = entrant.discountAccess[1].discount
            print("\(entrant.stringForPersonalInformation()) - You have \(discountOnFood)% discount on food and \(discountOnMerchandise)% discount on merchandise")
            return true
        }
    }
}


