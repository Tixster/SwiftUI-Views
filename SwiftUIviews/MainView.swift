//
//  MainView.swift
//  SwiftUIviews
//
//  Created by Кирилл Тила on 19.03.2022.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ExpenseTrackerView()
                    MarvelHeroesView()
                    SleepTimeView()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct ExpenseTrackerView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        NavigationLink(isActive: $isActive,
                       destination: {
            ExpenseTracker(rootIsActive: $isActive)
                .navigationBarHidden(true) },
                       label: { Text("Трекер расходов") })
        .isDetailLink(false)
    }
}

struct MarvelHeroesView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        NavigationLink(isActive: $isActive,
                       destination: {
            MarvelHeroes(isRoot: $isActive)
                .environment(\.colorScheme, .light)
                .navigationBarHidden(true)
        }, label: { Text("Герои марвел") })
        .isDetailLink(false)
    }
}

struct SleepTimeView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        NavigationLink(isActive: $isActive,
                       destination: {
            SleepTime()
                .environment(\.colorScheme, .light)
                .navigationBarHidden(false)
        }, label: { Text("Будильник") })
        .isDetailLink(false)
    }
}
