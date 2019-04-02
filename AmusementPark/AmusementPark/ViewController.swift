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
        
        // Comments the inner loops to test Guests, Employees or Managers
        for checkpoint in checkpoints {
            for guest in guests {
             guest.swipe(at: checkpoint)
            }
            
            /*for employee in employees {
                employee.swipe(at: checkpoint)
            }*/
            
            /*for manager in managers {
                manager.swipe(at: checkpoint)
            }*/
            
        }
    }
    

    func createCheckPoints() {
        checkpoints = [RestrictedAreaCheckpoint(aera: .amusement), RestrictedAreaCheckpoint(aera: .kitchen), RestrictedAreaCheckpoint(aera: .maintenance), RestrictedAreaCheckpoint(aera: .rideControl), RestrictedAreaCheckpoint(aera: .office), RegisterCheckPoint(), SkipTheLinesCheckpoint() ]
    }
    
    // Add or remove pass in the guestsPass array
    func createGuests() {
        let guest1 = Guest(entrantType: .classic)
        //guests.append(guest1)
        let guest2 = Guest(entrantType: .vip)
       // guests.append(guest2)
        do {
            let childEntrant1 = try ChildGuest(birthDate: "2017-04-02")
            //guests.append(childEntrant1)
            let childEntrant2 = try ChildGuest(birthDate: "2000-08-08")
            guests.append(childEntrant2)
        } catch EntrantError.missingDateOfBirth {
            print("Date of birth is missing")
        } catch EntrantError.tooOld {
            print("Child is too old")
        } catch let error {
            print("Unexpected error \(error)")
        }
    }
  
    // Add or remove pass in the employeesPass array
    func createEmployees() {
        let personalInformation1 = PersonalInformation(firstName: "Sheldon", lastName: "Cooper", streetAddress: "1 Infinite Loop", city: "Pasadena", state: "California", zipCode: "91001")
        let personalInformation2 = PersonalInformation(firstName: "Amy", lastName: "Fowler", streetAddress: "", city: "Pasadena", state: "", zipCode: "91001")
        let personalInformation3 = PersonalInformation(firstName: "Penny", lastName: "", streetAddress: "", city: "Ohmaha", state: "Nebraska", zipCode: "68197")
        let personalInformation4 = PersonalInformation(firstName: "Leonard", lastName: "Hofstader", streetAddress: "1 Infinite Loop", city: "Pasadena", state: "California", zipCode: "")
        
        do {
            let employeeEntrant1 = try Employee(entrantType: .food, personalInformation: personalInformation1)
            employees.append(employeeEntrant1)
            let employeeEntrant2 = try Employee(entrantType: .maintenance, personalInformation: personalInformation2)
            employees.append(employeeEntrant2)
            let employeeEntrant3 = try Employee(entrantType: .ride, personalInformation: personalInformation3)
            employees.append(employeeEntrant3)
            let employeeEntrant4 = try Employee(entrantType: .food, personalInformation: personalInformation4)
            employees.append(employeeEntrant4)
        } catch EntrantError.addressImcomplete {
            print("Address incomplete")
        } catch let error {
            print("Unexpected error \(error)")
        }
    }
    
    // Add or remove pass in the managersPass array 
    func createManagers() {
        let personalInformationManager1 = PersonalInformation(firstName: "Rajesh", lastName: "Kootrapali", streetAddress: "1 Infinite Loop", city: "Pasadena", state: "California", zipCode: "91001")
        let personalInformationManager2 = PersonalInformation(firstName: "Howard", lastName: "Wolowitz", streetAddress: "", city: "Pasadena", state: "California", zipCode: "91001")
        
        do {
            let managerEntrant1 = try Manager(personalInformation: personalInformationManager1)
            managers.append(managerEntrant1)
            let managerEntrant2 = try Manager(personalInformation: personalInformationManager2)
            managers.append(managerEntrant2)
        } catch EntrantError.addressImcomplete {
            print("Address incomplete")
        } catch let error {
            print("Unexpected error\(error) ")
        }
    }
}

