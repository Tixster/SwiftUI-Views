//
//  AnimatedText.swift
//  SwiftUIviews
//
//  Created by Кирилл Тила on 19.03.2022.
//

import SwiftUI

struct AnimatedText: View, Animatable {
    
    var value: CGFloat
    var animatableData: CGFloat {
        get { value }
        set { value = newValue }
    }
    
    var font: Font
    var floatingPoint: Int = 2
    var isCurrency: Bool = false
    var additionalString: String = ""
    
    private var text: String {
        return "\(isCurrency ? "$" : "")\(String(format: "%.\(floatingPoint)f", value))" + additionalString
    }
    
    var body: some View {
        Text(text)
            .font(font)
    }
}
