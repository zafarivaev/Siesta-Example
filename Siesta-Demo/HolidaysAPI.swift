//
//  API.swift
//  Siesta-Demo
//
//  Created by Zafar on 1/25/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import Siesta

struct HolidaysAPI {
  
    private static let service = Service(baseURL: "https://date.nager.at/api/v2")
    
    static let holidaysResource: Resource = {
        HolidaysAPI.service
            .resource("/publicholidays")
            .child("2019")
            .child("US")
    }()
    
}
