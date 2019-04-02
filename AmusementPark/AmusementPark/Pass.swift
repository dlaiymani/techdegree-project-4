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
    
    func printPass() {
        print(entrant.stringForPersonalInformation())
    }
    
    func isAuthorizedForArea(_ area: Area) -> Bool {
        if entrant.areaAccess.contains(area) {
            return true
        } else {
            return false
        }
    }
    
    func isAuthorizedToSkipTheLines() -> Bool {
        if entrant.rideAccess.contains(.skipTheLines) {
            return true
        } else {
            return false
        }
    }
    
    func doesAllowDiscounts() -> Bool {
        let discountOnFood = entrant.discountAccess[0].discount
        let discountOnMerchandise = entrant.discountAccess[1].discount
        if discountOnFood == 0.0 && discountOnMerchandise == 0.0 {
            return false
        } else {
            return true
        }
    }
    
    func authorizedDiscounts() -> [Double] {
        return [entrant.discountAccess[0].discount, entrant.discountAccess[1].discount]
    }
    
    func checkPersonalInformation() {
        do {
            if let personalInformation = entrant.getPersonalInformation() {
                guard personalInformation.firstName != "" else {
                    throw PersonalInformationEntryError.missingFirstName
                }
                guard personalInformation.lastName != "" else {
                    throw PersonalInformationEntryError.missingLastName
                }
                guard personalInformation.streetAddress != "" else {
                    throw PersonalInformationEntryError.missingStreetAddress
                }
                guard personalInformation.city != "" else {
                throw PersonalInformationEntryError.missingCity
                }
                guard personalInformation.state != "" else {
                    throw PersonalInformationEntryError.missingState
                }
                guard personalInformation.zipCode != "" else {
                    throw PersonalInformationEntryError.missingZipCode
                }
                
            } else {
                // Check if date of birth is correct i.e < 5
                if let childEntrant = entrant as? Guest, let dateOfBirth = childEntrant.birthDate {
                    let now = Date()
                    if now - dateOfBirth >= 5 {
                        throw DateOfBirthErrors.childTooOld
                    }
                }
            }
        } catch PersonalInformationEntryError.missingFirstName {
            print("First Name is missing")
        } catch PersonalInformationEntryError.missingLastName {
            print("Last Name is missing")
        } catch PersonalInformationEntryError.missingStreetAddress {
            print("Street Address is missing")
        } catch PersonalInformationEntryError.missingCity {
            print("City is missing")
        } catch PersonalInformationEntryError.missingState {
            print("State is missing")
        } catch PersonalInformationEntryError.missingZipCode {
            print("Zip Code is missing")
        } catch DateOfBirthErrors.childTooOld {
            print("Child is too old")
        } catch let error {
            fatalError("\(error)")
        }
    }
}

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
        
}
