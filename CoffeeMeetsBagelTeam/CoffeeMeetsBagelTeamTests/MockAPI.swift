//
//  MockAPI.swift
//  CoffeeMeetsBagelTeam
//
//  Created by Komran Ghahremani on 6/5/17.
//  Copyright © 2017 Komran Ghahremani. All rights reserved.
//

import UIKit

class MockAPI: API {
    var resultType: Result<[JSON]>
    
    init(resultType: Result<[JSON]>) {
        self.resultType = resultType
    }
    
    override func loadJSONFromRequest(completion: @escaping APICompletionHandler) {
        return completion(self.resultType)
    }
}
