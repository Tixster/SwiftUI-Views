//
//  MarvelHeroes.swift
//  MarvelHeroes
//
//  Created by Кирилл Тила on 12.02.2022.
//

import SwiftUI
import SPSafeSymbols

struct MarvelHeroes: View {
    
    @Binding var isRoot: Bool
    
    @StateObject var homeData: HomeViewModel = .init()
    
    var body: some View {
        TabView {
            CharacterView()
                .tabItem {
                    Image(.person._3Fill)
                    Text(homeData.characterViewTitle)
                }
                .environmentObject(homeData)
            
            ComicsView()
                .tabItem {
                    Image(.books.verticalFill)
                    Text("Комиксы")
                }
                .environmentObject(homeData)
            Text("Назад")
            .onAppear {
                isRoot = false
            }
            .tabItem {
                Image(.arrow.left)
                Text("Назад")
            }
        }
    }
}
