//
//  Today.swift
//  HeroAnimation
//
//  Created by Abdullah Karaboğa on 25.02.2023.
//

import SwiftUI

struct Today: Identifiable {

    var id = UUID().uuidString
    var itemName: String
    var itemDescription: String
    var itemLogo: String
    var bannerTitle: String
    var platformTitle: String
    var artwork: String
    
}

var todayItems: [Today] = [

    Today(itemName: "fds", itemDescription: "dfss", itemLogo: "fsdz", bannerTitle: "asf", platformTitle: "sdfs", artwork: "sfsdf")
]
