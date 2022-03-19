//
//  ComicsView.swift
//  MarvelHeroes
//
//  Created by Кирилл Тила on 12.02.2022.
//

import SwiftUI

struct ComicsView: View {
    
    @EnvironmentObject var homeData: HomeViewModel
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                if homeData.fetchedComics.isEmpty {
                    ProgressView()
                        .padding(.top, 30)
                } else {
                    VStack(spacing: 15) {
                        ForEach(homeData.fetchedComics) { comic in
                            ComicRowView(comic: comic)
                        }
                        
                        if homeData.offset == homeData.fetchedComics.count {
                            ProgressView()
                                .padding(.vertical)
                                .onAppear {
                                    print("Получение новых комиксов")
                                    homeData.searchComics()
                                }
                        } else {
                            GeometryReader { reader -> Color in
                                
                                let minY = reader.frame(in: .global).minY
                                let height = UIScreen.main.bounds.height / 1.3
                                
                                if !homeData.fetchedComics.isEmpty && minY < height {
                                    DispatchQueue.main.async {
                                        homeData.offset = homeData.fetchedComics.count
                                    }
                                }
                                
                                return .clear
                            }
                            .frame(width: 20, height: 20)
                        }
                    }
                    
                }
                
            }
            .navigationTitle("Комиксы Marvel")
        }
        .onAppear {
            if homeData.fetchedComics.isEmpty {
                homeData.searchComics()
            }
        }
    }
}
