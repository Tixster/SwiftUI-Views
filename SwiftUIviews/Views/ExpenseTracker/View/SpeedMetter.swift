//
//  SpeedMetter.swift
//  SwiftUIviews
//
//  Created by Кирилл Тила on 19.03.2022.
//

import SwiftUI
import SPSafeSymbols

struct SpeedMetter: View {
    
    @Binding var progress: CGFloat
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            ZStack {
                ForEach(1...60, id: \.self) { index in
                    let deg = CGFloat(index) * 3
                    Capsule()
                        .fill(.gray.opacity(0.25))
                        .frame(width: 40, height: 4)
                        .offset(x: -(size.width - 40) / 2)
                        .rotationEffect(.degrees(deg))
                }
            }
            .frame(width: size.width, height: size.height, alignment: .bottom)
            
            ZStack {
                ForEach(1...60, id: \.self) { index in
                    let deg = CGFloat(index) * 3
                    Capsule()
                        .fill(deg < 60 ? Color(#colorLiteral(red: 1, green: 0.9998993278, blue: 0.5203703642, alpha: 1)) : (deg >= 60 && deg < 120 ? Color(#colorLiteral(red: 0.7550474405, green: 1, blue: 0.4978662133, alpha: 1)) : Color(#colorLiteral(red: 0.5483565927, green: 1, blue: 0.6984652877, alpha: 1))))
                        .frame(width: 40, height: 4)
                        .offset(x: -(size.width - 40) / 2)
                        .rotationEffect(.degrees(deg))
                }
            }
            .frame(width: size.width, height: size.height, alignment: .bottom)
            .mask {
                Circle()
                    .trim(from: 0, to: (progress / 2) + 0.002)
                    .stroke(.white, lineWidth: 40)
                    .frame(width: size.width - 40, height: size.width - 40)
                    .offset(y: -(size.height) / 2)
                    .rotationEffect(.degrees(180))
            }
        }
        .overlay(alignment: .bottom, content: {
            HStack {
                Text("0%")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(Color.white)
                    .offset(x: 10)
                Spacer()
                AnimatedText(value: CGFloat(Int(progress * 100)),
                             font: .system(size: 15, weight: .semibold),
                             floatingPoint: 0,
                             additionalString: "%")
                .foregroundColor(Color.white)
            }
            .offset(y: 35)
        })
        .overlay(alignment: .bottom, content: {
            // MARK: - Indicator Shape
            IndicatorShape()
                .fill(Color(#colorLiteral(red: 0.6512084603, green: 0.6725544333, blue: 0.7721014619, alpha: 1)))
                .overlay(alignment: .bottom, content: {
                    Circle()
                        .fill(Color(#colorLiteral(red: 0.6512084603, green: 0.6725544333, blue: 0.7721014619, alpha: 1)))
                        .frame(width: 30, height: 30)
                        .overlay {
                            Circle()
                                .fill(Color(#colorLiteral(red: 0.1868699491, green: 0.1868699491, blue: 0.1868699491, alpha: 1)))
                                .padding(6)
                        }
                        .offset(y: 10)
                })
                .frame(width: 25)
                .padding(.top, 40)
                .rotationEffect(.degrees(-90), anchor: .bottom)
                .rotationEffect(.degrees(progress * 180), anchor: .bottom)
                .offset(y: -5)
        })
        .padding(.top)
        .padding(10)
    }
}

struct SpeedMetter_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
