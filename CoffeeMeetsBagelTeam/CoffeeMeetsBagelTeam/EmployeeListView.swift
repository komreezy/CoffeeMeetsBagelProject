//
//  EmployeeListView.swift
//  CoffeeMeetsBagelTeam
//
//  Created by Komran Ghahremani on 6/4/17.
//  Copyright © 2017 Komran Ghahremani. All rights reserved.
//

import Foundation

protocol EmployeeListView: class {
    func didLoadEmployeeData()
    func showAlert(_ message: String)
}
