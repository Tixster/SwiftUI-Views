//
//  Today.swift
//  SwiftUIviews
//
//  Created by Кирилл Тила on 17.04.2022.
//

import Foundation

struct Today: Identifiable {
    var id = UUID().uuidString
    var appName: String
    var appDescription: String
    var appLogo: String
    var bannerTitle: String
    var platformTitle: String
    var artwordk: String
}

var todayItems: [Today] = [
    .init(appName: "LEGO Brawls",
          appDescription: "Battle with friends online",
          appLogo: "Logo1",
          bannerTitle: "Smash your rivals in Lego Brawls",
          platformTitle: "Apple Arcade", artwordk: "Post1"),
    .init(appName: "Forza Horizon", appDescription: "Racing Game", appLogo: "Logo2", bannerTitle: "You're in charge of the Horizon Festival", platformTitle: "Apple Arcade", artwordk: "Post2")
]
