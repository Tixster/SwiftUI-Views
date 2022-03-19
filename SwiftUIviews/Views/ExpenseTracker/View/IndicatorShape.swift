//
//  IndicatorShape.swift
//  SwiftUIviews
//
//  Created by Кирилл Тила on 19.03.2022.
//

import SwiftUI
import SPSafeSymbols

struct IndicatorShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let width = rect.width
            let height = rect.height
            
            path.move(to: .init(x: width / 2, y: 0))
            path.addLine(to: .init(x: 0, y: height))
            path.addLine(to: .init(x: width, y: height))
        }
    }
}
