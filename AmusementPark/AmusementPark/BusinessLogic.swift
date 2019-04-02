//
//  BusinessLogic.swift
//  AmusementPark
//
//  Created by davidlaiymani on 01/04/2019.
//  Copyright © 2019 davidlaiymani. All rights reserved.
//

import Foundation

enum Area: String {
    case amusement
    case kitchen
    case rideControl
    case maintenance
    case office
}

enum RideAccess {
    case all
    case skipTheLines
}

enum DiscountAccess {
    case onFood(percentage: Double)
    case onMerchandise(percentage: Double)
    
    var discount: Double {
        switch self {
        case .onFood(let percentage): return percentage
        case .onMerchandise(let percentage): return percentage
        }
    }
}


enum EntrantType: String {
    case classic
    case vip
    case freeChild
    case food
    case ride
    case maintenance
    case manager
}

enum EntrantCategory: String {
    case guest
    case employee
    case manager
}

protocol Entrant {
    var areaAccess: [Area] { get }
    var rideAccess: [RideAccess] { get }
    var discountAccess: [DiscountAccess] { get }
    var entrantCategory: EntrantCategory { get }
    var entrantType: EntrantType { get }
    
    func stringForEntrantPass() -> String
    func stringForPersonalInformation() -> String
    func getPersonalInformation() -> PersonalInformation?
}

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
    
    var birthDate: Date?
    
    init(entrantType: EntrantType) {
        self.entrantType = entrantType
        self.entrantCategory = .guest
    }
    
    convenience init(childBornOn: Date) {
        self.init(entrantType: EntrantType.freeChild)
        self.birthDate = childBornOn
    }
    
    func stringForEntrantPass() -> String {
        return "\(self.entrantCategory) \(self.entrantType) Pass"
    }
    
    func stringForPersonalInformation() -> String {
        if self.entrantType == .freeChild {
            return "Personal Information: Date of birth: \(birthDate)"
        } else {
            return "No personal information to display"
        }
    }
    
    func getPersonalInformation() -> PersonalInformation? {
        return nil
    }
}



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

    init(entrantType: EntrantType, personalInformation: PersonalInformation) {
        self.entrantCategory = .employee
        self.entrantType = entrantType
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

class Manager: Entrant {
    var entrantCategory: EntrantCategory
    var entrantType: EntrantType
    var areaAccess: [Area] {
        return [.amusement, .kitchen, .rideControl, .maintenance]
    }
    var rideAccess: [RideAccess] {
        return [RideAccess.all]
    }
    var discountAccess: [DiscountAccess] {
        return [DiscountAccess.onFood(percentage: 25), DiscountAccess.onMerchandise(percentage: 25)]
    }

    var personalInformation: PersonalInformation

    init(personalInformation: PersonalInformation) {
        self.personalInformation = personalInformation
        self.entrantCategory = .manager
        self.entrantType = .manager
    }
    
    func stringForEntrantPass() -> String {
        return "\(self.entrantCategory) Pass"
    }
    
    func stringForPersonalInformation() -> String {
        return "Personal Information: \(self.personalInformation.description)"
    }

    func getPersonalInformation() -> PersonalInformation? {
        return self.personalInformation
    }
}


