//
//  CustomCornerns.swift
//  SwiftUIviews
//
//  Created by Кирилл Тила on 17.04.2022.
//

import SwiftUI

struct CustomCornerns: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    func path(in rect: CGRect) -> Path {
        let path: UIBezierPath = .init(roundedRect: rect, byRoundingCorners: corners, cornerRadii: .init(width: radius, height: radius))
        return .init(path.cgPath)
    }
}
