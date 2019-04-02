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
    
    func swipe(pass: Pass)
}


// Checkpoint for restricted areas
class RestrictedAreaCheckpoint: Checkpoint {
    var type: CheckpointType
    var area: Area
    
    init(aera: Area) {
        self.area = aera
        self.type = .restrictedArea
    }
    
    
    func swipe(pass: Pass) {
        if pass.isAuthorizedForArea(area) {
            print("\(pass.entrantPassTitle) - Authorized access to: \(area.rawValue)")
        } else {
            print("\(pass.entrantPassTitle) - You have not the access right to enter this area: \(area.rawValue)")
        }
    }
}

// Checkpoint for skip lines
class SkipTheLinesCheckpoint: Checkpoint {
    var type: CheckpointType
    
    init() {
        self.type = .skipTheLines
    }

    func swipe(pass: Pass) {
        if pass.isAuthorizedToSkipTheLines() {
            print("\(pass.entrantPassTitle) - You can the skip the line")
        } else {
            print("\(pass.entrantPassTitle) - You have not the access right to skip the line")
        }
    }
}

// register checkpoint
class RegisterCheckPoint: Checkpoint {
    
    var type: CheckpointType
    
    init() {
        self.type = .register
    }
    
    func swipe(pass: Pass) {
        if !pass.doesAllowDiscounts() {
            print("\(pass.entrantPassTitle) - No discount")
        } else {
            let discountOnFood = pass.authorizedDiscounts()[0]
            let discountOnMerchandise = pass.authorizedDiscounts()[1]
            print("\(pass.entrantPassTitle) - You have \(discountOnFood)% discount on food and \(discountOnMerchandise)% discount on merchandise")
        }
    }
}


