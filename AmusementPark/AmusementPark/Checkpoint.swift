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

protocol Checkpoint {
    var type: CheckpointType { get }
    
    func swipe(entrant: Entrant)
}


class RestrictedAreaCheckpoint: Checkpoint {
    var type: CheckpointType
    var area: Area
    
    init(aera: Area) {
        self.area = aera
        self.type = .restrictedArea
    }
    
    
    func swipe(entrant: Entrant) {
        if entrant.areaAccess.contains(area) {
            print("Authorized access")
        } else {
            print("You have not the access right to enter this area \(area.rawValue)")
        }
    }
}


class SkipTheLinesCheckpoint: Checkpoint {
    var type: CheckpointType
    
    init() {
        self.type = .skipTheLines
    }

    func swipe(entrant: Entrant) {
        if entrant.rideAccess.contains(.skipTheLines) {
            print("You can the skip the line")
        } else {
            print("You have not the access right to skip the line")
        }
    }
}

class RegisterCheckPoint: Checkpoint {
    
    var type: CheckpointType
    
    init() {
        self.type = .register
    }
    
    
    func swipe(entrant: Entrant) {
        let discountOnFood = entrant.discountAccess[0].discount
        let discountOnMerchandise = entrant.discountAccess[1].discount
        if discountOnFood == 0.0 && discountOnMerchandise == 0.0 {
            print("No discount")
        } else {
            print("You have \(discountOnFood)% discount on food and \(discountOnMerchandise)% discount on merchandise")
        }
    }
}


