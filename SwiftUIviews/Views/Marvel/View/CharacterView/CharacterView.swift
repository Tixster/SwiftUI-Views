//
//  CharacterView.swift
//  MarvelHeroes
//
//  Created by Кирилл Тила on 12.02.2022.
//

import SwiftUI
import SPSafeSymbols

struct CharacterView: View {
    
    @EnvironmentObject var homeData: HomeViewModel
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    HStack(spacing: 10) {
                        Image(.magnifyingglass)
                            .foregroundColor(.gray)
                        TextField("Поиск персонажа", text: $homeData.searchQuery)
                            .textInputAutocapitalization(.none)
                            .disableAutocorrection(true)
                            .submitLabel(.done)
                            .font(.body.bold())
                            .foregroundColor(.black)
                        
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(color: .black.opacity(0.06), radius: 5, x: 5, y: 5)
                    .shadow(color: .black.opacity(0.06), radius: 5, x: -5, y: -5)
                }
                .padding()
                
                if let characters = homeData.fetchedCharacter {
                    if characters.isEmpty {
                        Text("Нет результатов")
                            .padding(.top, 20)
                    } else {
                        ForEach(characters) { data in
                            CharacterRowView(character: data)
                        }
                    }
                    
                    
                } else {
                    if !homeData.searchQuery.isEmpty {
                        ProgressView()
                            .padding(.top, 20)
                    }
                }
                
            }
            .navigationTitle(homeData.characterViewTitle)
        }
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
