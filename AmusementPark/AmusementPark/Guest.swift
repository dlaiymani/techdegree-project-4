//
//  Guest.swift
//  AmusementPark
//
//  Created by davidlaiymani on 02/04/2019.
//  Copyright © 2019 davidlaiymani. All rights reserved.
//

import Foundation

// Guest class. Implements Entrant protocol
class Guest: Entrant {
    var entrantType: EntrantType
    var entrantCategory: EntrantCategory
    var areaAccess: [Area] {
        switch self.entrantType {
        case .classic: return [.amusement]
        case .vip: return [.amusement]
        case .freeChild: return [.amusement]
        default: return []
        }
    }
    var rideAccess: [RideAccess] {
        switch self.entrantType {
        case .classic: return [.all]
        case .vip: return [.all, .skipTheLines]
        case .freeChild: return [.all]
        default: return []
            
        }
    }
    var discountAccess: [DiscountAccess] {
        switch self.entrantType {
        case .classic: return [.onFood(percentage: 0), .onMerchandise(percentage: 0)]
        case .vip: return [.onFood(percentage: 10), .onMerchandise(percentage: 20)]
        case .freeChild: return [.onFood(percentage: 0), .onMerchandise(percentage: 0)]
        default: return []
            
        }
    }
    
    init(entrantType: EntrantType) {
        self.entrantType = entrantType
        self.entrantCategory = .guest
    }
    
    func swipe(at checkpoint: Checkpoint) -> Bool {
        return checkpoint.validateAccess(entrant: self)
    }
    
    func stringForPersonalInformation() -> String {
        return "No personal information to display"
    }
}

// ChildGuest class, inherits from Guest
class ChildGuest: Guest {
    var birthDate: Date
    
    init(birthDate: String) throws {
        
        if let birthDate = birthDate.createDate() { // test if birth date is renseigned
            self.birthDate = birthDate
        } else {
            throw EntrantError.missingDateOfBirth
        }
        super.init(entrantType: EntrantType.freeChild)

        // Test if the age is correct i.e <= 5
        guard validateDateOfBirth() else {
            throw EntrantError.tooOld
        }
    }
    
    // Test if the child is too old or not
    func validateDateOfBirth() -> Bool {
        let now = Date()
        let interval = now.timeIntervalSince(self.birthDate)
        if  interval/31536000 >= 5 { // Must exist better solution
            return false
        } else {
            return true
        }
    }
    
    override func swipe(at checkpoint: Checkpoint) -> Bool {
        //checkpoint.checkBirthday(entrant: self)
        return checkpoint.validateAccess(entrant: self)
    }
    
    override func stringForPersonalInformation() -> String {
        var returnString = "Personal Information: Date of birth: \(self.birthDate). "
        if self.birthDate.isBirthday() {
            returnString += "Hey It's your birthday today: Happy Birthday 🎂 🎈"
        }
        return returnString
    }
}
