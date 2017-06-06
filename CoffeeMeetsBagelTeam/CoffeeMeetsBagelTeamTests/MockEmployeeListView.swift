//
//  MockTeamViewModel.swift
//  CoffeeMeetsBagelTeam
//
//  Created by Komran Ghahremani on 6/5/17.
//  Copyright © 2017 Komran Ghahremani. All rights reserved.
//

import UIKit

class MockEmployeeListView: EmployeeListView {
    var dataDidLoadCalled = false
    var errorPromptCalled = false
    
    func didLoadEmployeeData() {
        dataDidLoadCalled = true
    }
    
    func showAlert(_ message: String) {
        errorPromptCalled = true
    }
}
