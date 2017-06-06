//
//  TeamViewModel.swift
//  CoffeeMeetsBagelTeam
//
//  Created by Komran Ghahremani on 6/4/17.
//  Copyright © 2017 Komran Ghahremani. All rights reserved.
//

import UIKit

class TeamViewModel: NSObject {
    unowned fileprivate var view: EmployeeListView
    fileprivate var api: API
    var employees: [Employee]
    var gradient: [CGColor]
    
    required init(view: EmployeeListView, _ api: API = API.shared) {
        self.view = view
        self.api = api
        employees = []
        gradient = []
    }
    
    func fetchEmployeeData() {
        api.loadJSONFromRequest { result in
            switch result {
            case .success(let json):
                self.employees = json.flatMap(Employee.init)
                self.view.didLoadEmployeeData()
            case .failure:
                self.view.showAlert("something went wrong.")
            }
        }
    }
}
