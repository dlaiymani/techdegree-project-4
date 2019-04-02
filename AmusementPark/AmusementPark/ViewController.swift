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
    var guestsPass = [Pass]()
    var employeesPass = [Pass]()
    var managersPass = [Pass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createCheckPoints()
        createGuestsPass()
        createEmployeesPass()
        createManagersPass()
        
        for checkpoint in checkpoints {
           /* for guestPass in guestsPass {
               checkpoint.swipe(pass: guestPass)
            }*/
            
            for employeePass in employeesPass {
                checkpoint.swipe(pass: employeePass)
            }
            
           /* for managerPass in managersPass {
                checkpoint.swipe(entrant: managerPass)
            }*/
            
        }
    }
    

    func createCheckPoints() {
        checkpoints = [RestrictedAreaCheckpoint(aera: .amusement), RestrictedAreaCheckpoint(aera: .kitchen), RestrictedAreaCheckpoint(aera: .maintenance), RestrictedAreaCheckpoint(aera: .rideControl), RestrictedAreaCheckpoint(aera: .office), RegisterCheckPoint(), SkipTheLinesCheckpoint() ]
    }
    
    func createGuestsPass() {
        if let childDateOfBirth = createDate(from: "2017/10/10"), let adultDateOfBirth = createDate(from: "2000/08/08") {
            let pass1 = Pass(entrant: Guest(entrantType: .classic))
            let pass2 = Pass(entrant: Guest(entrantType: .vip))
            let pass3 = Pass(entrant: Guest(childBornOn: childDateOfBirth))
            let pass4 = Pass(entrant: Guest(childBornOn: adultDateOfBirth))
            guestsPass = [pass4]
        }
        
    }
  
    func createEmployeesPass() {
        let personalInformation1 = PersonalInformation(firstName: "Sheldon", lastName: "Cooper", streetAddress: "1 Infinite Loop", city: "Pasadena", state: "California", zipCode: "91001")
        let personalInformation2 = PersonalInformation(firstName: "Amy", lastName: "Fowler", streetAddress: "", city: "Pasadena", state: "", zipCode: "91001")
        let personalInformation3 = PersonalInformation(firstName: "Penny", lastName: "", streetAddress: "", city: "Ohmaha", state: "Nebraska", zipCode: "68197")
        let personalInformation4 = PersonalInformation(firstName: "Leonard", lastName: "Hofstader", streetAddress: "1 Infinite Loop", city: "Pasadena", state: "California", zipCode: "")
        let pass1 = Pass(entrant: Employee(entrantType: .food, personalInformation: personalInformation1))
        let pass2 = Pass(entrant: Employee(entrantType: .maintenance, personalInformation: personalInformation2))
        let pass3 = Pass(entrant: Employee(entrantType: .ride, personalInformation: personalInformation3))
        let pass4 = Pass(entrant: Employee(entrantType: .food, personalInformation: personalInformation4))
        employeesPass = [pass3]
    }
    
    func createManagersPass() {
        
        let personlInformationManager1 = PersonalInformation(firstName: "Rajesh", lastName: "Kootrapali", streetAddress: "1 Infinite Loop", city: "Pasadena", state: "California", zipCode: "91001")
        let personlInformationManager2 = PersonalInformation(firstName: "Howard", lastName: "Wolowitz", streetAddress: "", city: "Pasadena", state: "California", zipCode: "91001")
        let pass1 = Pass(entrant: Manager(personalInformation: personlInformationManager1))
        let pass2 = Pass(entrant: Manager(personalInformation: personlInformationManager2))
        managersPass = [pass1, pass2]
        
    }
    
    func createDate(from date: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.date(from: date) ?? nil
    }
    

}

