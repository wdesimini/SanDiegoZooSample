//
//  Experience.swift
//  SanDiegoZooSample
//
//  Created by Wilson Desimini on 3/12/19.
//  Copyright © 2019 Wilson Desimini. All rights reserved.
//

class Experience {
    var imageString: String?
    let title: String
    let description: String
    let times: String?
    let duration: String?
    let ageInterest: String?
    let price: String?
    let ticketsURL: String?
    var location: String?
    
    init(imageString: String? = "zoo_logo", title: String, description: String, times: String? = nil, duration: String? = nil, ageInterest: String? = nil, price: String? = nil, ticketsURL: String? = nil, location: String? = nil) {
        
        self.title = title
        self.description = description
        self.imageString = imageString
        self.times = times
        self.duration = duration
        self.ageInterest = ageInterest
        self.price = price
        self.ticketsURL = ticketsURL
        self.location = location
    }
    
    var type: ExperienceType {
        get { return .unknown }
    }
}
