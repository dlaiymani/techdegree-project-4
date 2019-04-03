//
//  Manager.swift
//  AmusementPark
//
//  Created by davidlaiymani on 02/04/2019.
//  Copyright © 2019 davidlaiymani. All rights reserved.
//

import Foundation


// Manager class. Implements Entrant protocol
class Manager: Entrant {
    var entrantCategory: EntrantCategory
    var entrantType: EntrantType
    var areaAccess: [Area] {
        return [.amusement, .kitchen, .rideControl, .maintenance, .office]
    }
    var rideAccess: [RideAccess] {
        return [RideAccess.all]
    }
    var discountAccess: [DiscountAccess] {
        return [DiscountAccess.onFood(percentage: 25), DiscountAccess.onMerchandise(percentage: 25)]
    }
    
    var personalInformation: PersonalInformation
    
    init(personalInformation: PersonalInformation) throws {
        if !personalInformation.validatePersonalInformation() {
            throw EntrantError.addressImcomplete
        }
        self.personalInformation = personalInformation
        self.entrantCategory = .manager
        self.entrantType = .manager
    }
    
    func swipe(at checkpoint: Checkpoint) -> Bool {
        return checkpoint.validateAccess(entrant: self)
    }
    
    
    func stringForPersonalInformation() -> String {
        return "Personal Information: \(self.personalInformation.description)"
    }
    
}

