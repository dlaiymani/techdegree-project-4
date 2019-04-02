//
//  Employee.swift
//  AmusementPark
//
//  Created by davidlaiymani on 02/04/2019.
//  Copyright © 2019 davidlaiymani. All rights reserved.
//

import Foundation


// Employee class. Implements Entrant protocol
class Employee: Entrant {
    var entrantType: EntrantType
    var entrantCategory: EntrantCategory
    var areaAccess: [Area] {
        switch self.entrantType {
        case .food: return [.amusement, .kitchen]
        case .ride: return [.amusement, .rideControl]
        case .maintenance: return [.amusement, .kitchen, .rideControl, .maintenance]
        default: return []
            
        }
    }
    var rideAccess: [RideAccess] {
        return [RideAccess.all]
    }
    var discountAccess: [DiscountAccess] {
        return [DiscountAccess.onFood(percentage: 15), DiscountAccess.onMerchandise(percentage: 25)]
    }

    var personalInformation: PersonalInformation
    
    init(entrantType: EntrantType, personalInformation: PersonalInformation) throws {
        self.entrantCategory = .employee
        self.entrantType = entrantType
        
        if !personalInformation.validatePersonalInformation() {
            throw EntrantError.addressImcomplete
        }
        
        self.personalInformation = personalInformation
    }
    
    
    func stringForEntrantPass() -> String {
        return "\(self.entrantCategory) \(self.entrantType) Service Pass"
    }
    
    func stringForPersonalInformation() -> String {
        return "Personal Information: \(self.personalInformation.description)"
    }
    
    func getPersonalInformation() -> PersonalInformation? {
        return self.personalInformation
    }
    
}
