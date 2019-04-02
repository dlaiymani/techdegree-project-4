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
        
        // Comments the inner loops to test Guests, Employees or Managers
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
    
    // Add or remove pass in the guestsPass array (last line)
    func createGuestsPass() {
        let pass1 = Pass(entrant: Guest(entrantType: .classic))
        let pass2 = Pass(entrant: Guest(entrantType: .vip))
        do {
            let childEntrant = try ChildGuest(birthDate: "2017/10/10")
            guestsPass.append(Pass(entrant: childEntrant))
        } catch EntrantError.missingDateOfBirth {
            print("Date of birth is missing")
        } catch EntrantError.tooOld {
            print("Child is too old")
        } catch let error {
            print("Unexpected error")
        }

        do {
            let childEntrant = try ChildGuest(birthDate: "2000/08/08")
            guestsPass.append(Pass(entrant: childEntrant))

        } catch EntrantError.missingDateOfBirth {
            print("Date of birth is missing")
        } catch EntrantError.tooOld {
            print("Child is too old")
        } catch let error {
            print("Unexpected error")
        }
    }
  
    // Add or remove pass in the employeesPass array (last line)
    func createEmployeesPass() {
        let personalInformation1 = PersonalInformation(firstName: "Sheldon", lastName: "Cooper", streetAddress: "1 Infinite Loop", city: "Pasadena", state: "California", zipCode: "91001")
        let personalInformation2 = PersonalInformation(firstName: "Amy", lastName: "Fowler", streetAddress: "", city: "Pasadena", state: "", zipCode: "91001")
        let personalInformation3 = PersonalInformation(firstName: "Penny", lastName: "", streetAddress: "", city: "Ohmaha", state: "Nebraska", zipCode: "68197")
        let personalInformation4 = PersonalInformation(firstName: "Leonard", lastName: "Hofstader", streetAddress: "1 Infinite Loop", city: "Pasadena", state: "California", zipCode: "")
        
        do {
            let employeeEntrant1 = try Employee(entrantType: .food, personalInformation: personalInformation1)
            employeesPass.append(Pass(entrant: employeeEntrant1))
            let employeeEntrant2 = try Employee(entrantType: .maintenance, personalInformation: personalInformation2)
            employeesPass.append(Pass(entrant: employeeEntrant1))
            let employeeEntrant3 = try Employee(entrantType: .ride, personalInformation: personalInformation3)
            employeesPass.append(Pass(entrant: employeeEntrant1))
            let employeeEntrant4 = try Employee(entrantType: .food, personalInformation: personalInformation4)
            employeesPass.append(Pass(entrant: employeeEntrant1))
        } catch EntrantError.addressImcomplete {
            print("Address incomplete")
        } catch let error {
            print("Unexpected error")
        }
    }
    
    // Add or remove pass in the managersPass array (last line)
    func createManagersPass() {
        let personlInformationManager1 = PersonalInformation(firstName: "Rajesh", lastName: "Kootrapali", streetAddress: "1 Infinite Loop", city: "Pasadena", state: "California", zipCode: "91001")
        let personlInformationManager2 = PersonalInformation(firstName: "Howard", lastName: "Wolowitz", streetAddress: "", city: "Pasadena", state: "California", zipCode: "91001")
        
        do {
            let managerEntrant1 = try Manager(personalInformation: personlInformationManager1)
            managersPass.append(Pass(entrant: managerEntrant1))
            let managerEntrant2 = try Manager(personalInformation: personlInformationManager2)
            managersPass.append(Pass(entrant: managerEntrant2))
        } catch EntrantError.addressImcomplete {
            print("Address incomplete")
        } catch let error {
            print("Unexpected error")
        }
    }
}

