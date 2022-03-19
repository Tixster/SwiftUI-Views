//
//  ExpenseTracker.swift
//  SwiftUIviews
//
//  Created by Кирилл Тила on 19.03.2022.
//

import SwiftUI
import SPSafeSymbols

struct ExpenseTracker: View {
    
    @Binding var rootIsActive: Bool
    
    @State var progress: CGFloat = 0.5
    @State var currentMonth: String = "Jan"
    @Namespace var animation
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Button {
                    rootIsActive = false
                } label: {
                    Image(.arrow.left)
                        .frame(width: 40, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .stroke(.gray.opacity(0.4), lineWidth: 1)
                        )
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(.ellipsis)
                        .font(.title3)
                        .rotationEffect(.degrees(-90))
                }
                
                
            }
            .foregroundColor(.white)
            .padding(.horizontal)
            
            // MARK: - Custom Gradient Card
            VStack {
                Text("Saved This Month")
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.7))
                AnimatedText(value: progress * 1299,
                             font: .system(size: 35, weight: .black),
                             isCurrency: true)
                .foregroundColor(Color(#colorLiteral(red: 0.7011701465, green: 0.7695797086, blue: 0, alpha: 1)))
                .padding(.top, 5)
                .lineLimit(1)
                
                SpeedMetter(progress: $progress)
            }
            .padding(.top, 50)
            .frame(maxWidth: .infinity)
            .frame(height: 340)
            .background {
                RoundedRectangle(cornerRadius: 45, style: .continuous)
                    .fill(
                        .linearGradient(colors: [
                            Color(#colorLiteral(red: 0.1354771852, green: 0.5635005832, blue: 0, alpha: 1)).opacity(0.4),
                            Color(#colorLiteral(red: 0.1354771852, green: 0.5635005832, blue: 0, alpha: 1)).opacity(0.2),
                            Color(#colorLiteral(red: 0.1354771852, green: 0.5635005832, blue: 0, alpha: 1)).opacity(0.1),
                        ] + Array(repeating: Color.clear, count: 5),
                                        startPoint: .topTrailing,
                                        endPoint: .bottomLeading)
                    )
            }
            .padding(.top, 15)
            .padding(.horizontal, 15)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(months, id: \.self) { month in
                                Text(month)
                                    .font(.callout)
                                    .foregroundColor(Color.white)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 15)
                                    .background {
                                        if currentMonth == month {
                                            Capsule()
                                                .fill(.black)
                                                .matchedGeometryEffect(id: "MONTH", in: animation)
                                        }
                                    }
                                    .onTapGesture {
                                        withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0)) {
                                            currentMonth = month
                                            progress = progressList[getIndex(month: month)]
                                        }
                                    }
                            }
                        }
                    }
                    BottomContent()
                        .padding(.top)
                }
                .padding()
            }
            .padding(.top, 30)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 15)
        .background(Color(#colorLiteral(red: 0.1868699491, green: 0.1868699491, blue: 0.1868699491, alpha: 1))
            .ignoresSafeArea())
    }
    
    @ViewBuilder
    private func BottomContent() -> some View {
        VStack(spacing: 15) {
            ForEach(expenses) { expense in
                HStack(spacing: 8) {
                    Image(systemName: expense.icon)
                        .resizable()
                        .frame(width: 35, height: 35)
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text(expense.title)
                            .fontWeight(.bold)
                        Text(expense.subTitle)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Text(expense.amount)
                        .fontWeight(.bold)
                }
                .padding()
                .foregroundColor(.white)
            }
        }
    }
    
    private func getIndex(month: String) -> Int {
        return months.firstIndex { value in
            month == value
        } ?? 0
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
