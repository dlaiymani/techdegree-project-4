//
//  BusinessLogic.swift
//  AmusementPark
//
//  Created by davidlaiymani on 01/04/2019.
//  Copyright © 2019 davidlaiymani. All rights reserved.
//

import Foundation

enum AreaAccess {
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
    case none
    case onFood(percentage: Double)
    case onMerchandise(percentage: Double)
}

enum GuestType {
    case classic
    case vip
    case freeChild
}

enum EmployeeType {
    case food
    case ride
    case maintenance
}

struct PersonalInformation  {
    var firstName: String
    var lastName: String
    var streetAddress: String
    var city: String
    var state: String
    var zipCode: String

}

protocol Entrant {
    var areaAccess: [AreaAccess] { get }
    var rideAccess: [RideAccess] { get }
    var discountAccess: [DiscountAccess] { get }
}

// Guest class. Implements Entrant protocol
class Guest: Entrant {
    var type: GuestType
    var areaAccess: [AreaAccess] {
        switch self.type {
        case .classic: return [.amusement]
        case .vip: return [.amusement]
        case .freeChild: return [.amusement]
        }
    }
    var rideAccess: [RideAccess] {
        switch self.type {
        case .classic: return [.all]
        case .vip: return [.all, .skipTheLines]
        case .freeChild: return [.all]
        }
    }
    var discountAccess: [DiscountAccess] {
        switch self.type {
        case .classic: return [.none]
        case .vip: return [.onFood(percentage: 10), .onMerchandise(percentage: 20)]
        case .freeChild: return [.none]
        }
    }
    
    var birthDate: Date?
    
    init(type: GuestType) {
        self.type = type
    }
    
    convenience init(childBornOn: Date) {
        self.init(type: GuestType.freeChild)
        self.birthDate = childBornOn
    }
}



class Employee: Entrant {
    var type: EmployeeType
    var areaAccess: [AreaAccess] {
        switch self.type {
        case .food: return [.amusement, .kitchen]
        case .ride: return [.amusement, .rideControl]
        case .maintenance: return [.amusement, .kitchen, .rideControl, .maintenance]
        }
    }
    var rideAccess: [RideAccess] {
        return [RideAccess.all]
    }
    var discountAccess: [DiscountAccess] {
        return [DiscountAccess.onFood(percentage: 15), DiscountAccess.onMerchandise(percentage: 25)]
    }
    
    var personalInformation: PersonalInformation

    init(type: EmployeeType, personalInformation: PersonalInformation) {
        self.type = type
        self.personalInformation = personalInformation
    }

}

class Manager: Entrant {
    
    var areaAccess: [AreaAccess] {
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
    }

}
