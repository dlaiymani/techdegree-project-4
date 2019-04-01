//
//  ViewController.swift
//  AmusementPark
//
//  Created by davidlaiymani on 01/04/2019.
//  Copyright © 2019 davidlaiymani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var checkpoints = [Checkpoint]()
    var guests = [Guest]()
    var employees = [Employee]()
    var managers = [Manager]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createCheckPoints()
        createGuests()
        createEmployees()
        createManagers()
        
        for checkpoint in checkpoints {
            for guest in guests {
               checkpoint.swipe(entrant: guest)
            }
        }
        

    }
    

    func createCheckPoints() {
        checkpoints = [RestrictedAreaCheckpoint(aera: .amusement), RestrictedAreaCheckpoint(aera: .kitchen), RestrictedAreaCheckpoint(aera: .maintenance), RestrictedAreaCheckpoint(aera: .rideControl), RestrictedAreaCheckpoint(aera: .office), RegisterCheckPoint(), SkipTheLinesCheckpoint() ]
    }
    
    func createGuests() {
        if let childDateOfBirth = createDate(from: "2017/10/10"), let adultDateOfBirth = createDate(from: "2000/08/08") {
            guests = [Guest(type: .classic), Guest(type: .vip), Guest(childBornOn: childDateOfBirth), Guest(childBornOn: adultDateOfBirth)]
        }
        
    }
    
    func createEmployees() {
        let personalInformation1 = PersonalInformation(firstName: "Sheldon", lastName: "Cooper", streetAddress: "1 Infinite Loop", city: "Pasadena", state: "California", zipCode: "91001")
        let personalInformation2 = PersonalInformation(firstName: "Amy", lastName: "Fowler", streetAddress: "", city: "Pasadena", state: "", zipCode: "91001")
        let personalInformation3 = PersonalInformation(firstName: "Penny", lastName: "", streetAddress: "", city: "Ohmaha", state: "Nebraska", zipCode: "68197")
        let personalInformation4 = PersonalInformation(firstName: "Leonard", lastName: "Hofstader", streetAddress: "1 Infinite Loop", city: "Pasadena", state: "California", zipCode: "")
        employees = [Employee(type: .food, personalInformation: personalInformation1), Employee(type: .maintenance, personalInformation: personalInformation2), Employee(type: .ride, personalInformation: personalInformation3), Employee(type: .food, personalInformation: personalInformation4)]
    }
    
    func createManagers() {
        
        let personlInformationManager1 = PersonalInformation(firstName: "Rajesh", lastName: "Kootrapali", streetAddress: "1 Infinite Loop", city: "Pasadena", state: "California", zipCode: "91001")
        let personlInformationManager2 = PersonalInformation(firstName: "Howard", lastName: "Wolowitz", streetAddress: "", city: "Pasadena", state: "California", zipCode: "91001")
        managers = [Manager(personalInformation: personlInformationManager1), Manager(personalInformation: personlInformationManager2)]
        
    }
    
    func createDate(from date: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.date(from: date) ?? nil
    }
    

}

