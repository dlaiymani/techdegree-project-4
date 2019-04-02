//
//  Pass.swift
//  AmusementPark
//
//  Created by davidlaiymani on 02/04/2019.
//  Copyright © 2019 davidlaiymani. All rights reserved.
//

import Foundation

class Pass {
    var entrant: Entrant
    var entrantPassTitle: String
    
    init(entrant: Entrant) {
        self.entrant = entrant
        entrantPassTitle = entrant.stringForEntrantPass()
    }
    
    // Print the personal information of the pass
    func printPass() {
        print(entrant.stringForPersonalInformation())
    }
    
    // Check if the pass allows the access to restricted areas
    func isAuthorizedForArea(_ area: Area) -> Bool {
        if entrant.areaAccess.contains(area) {
            return true
        } else {
            return false
        }
    }
    
    // Check if the pass allows to skip the lines
    func isAuthorizedToSkipTheLines() -> Bool {
        if entrant.rideAccess.contains(.skipTheLines) {
            return true
        } else {
            return false
        }
    }
    
    // Check if the pass allows some discounts
    func doesAllowDiscounts() -> Bool {
        let discountOnFood = entrant.discountAccess[0].discount
        let discountOnMerchandise = entrant.discountAccess[1].discount
        if discountOnFood == 0.0 && discountOnMerchandise == 0.0 {
            return false
        } else {
            return true
        }
    }
    
    // Return the different discounts
    func authorizedDiscounts() -> [Double] {
        return [entrant.discountAccess[0].discount, entrant.discountAccess[1].discount]
    }
    
}


