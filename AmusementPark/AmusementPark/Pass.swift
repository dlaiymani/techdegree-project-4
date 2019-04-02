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
    
    // Check if some personal information is missing
    func checkPersonalInformation() {
        do {
            if let personalInformation = entrant.getPersonalInformation() {
                
                if personalInformation.firstName == "" {
                    throw PersonalInformationEntryError.missingFirstName
                }
                if personalInformation.lastName == "" {
                    throw PersonalInformationEntryError.missingLastName
                }
                if personalInformation.streetAddress == "" {
                    throw PersonalInformationEntryError.missingStreetAddress
                }
                if personalInformation.city == "" {
                    throw PersonalInformationEntryError.missingCity
                }
                if personalInformation.state == "" {
                    throw PersonalInformationEntryError.missingState
                }
                if personalInformation.zipCode == "" {
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

// Allow to compute the difference between two dates
extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
        
}
