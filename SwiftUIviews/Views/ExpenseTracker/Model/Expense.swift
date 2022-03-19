//
//  Expense.swift
//  SwiftUIviews
//
//  Created by Кирилл Тила on 19.03.2022.
//

import SwiftUI
import SPSafeSymbols

struct Expense: Identifiable {
    var id: String = UUID().uuidString
    var icon: String
    var title: String
    var subTitle: String
    var amount: String
}

var expenses: [Expense] = [
    .init(icon: "cart.circle.fill", title: "Food", subTitle: "K Food Restaurant", amount: "$145.00"),
    .init(icon: "cart.circle.fill", title: "Taxo", subTitle: "Taxi Payment", amount: "$45.90"),
    .init(icon: "cart.circle.fill", title: "Netlfix", subTitle: "Subscription", amount: "$22.00")
]

let months: [String] = ["Jan", "Feb", "Mar", "Apr", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
let progressList: [CGFloat] = [0.1, 0.4, 0.9, 0.5, 0.3, 0.8, 0.6, 0.2, 0.89, 0.45, 0.98, 0.32]
