//
//  CharacterRowView.swift
//  MarvelHeroes
//
//  Created by Кирилл Тила on 12.02.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterRowView: View {
    typealias URLData = [String: String]
    var character: Character
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            WebImage(url: extractImage(data: character.thumbnail))
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(character.name)
                    .font(.title3.bold())
                Text(character.description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                Spacer()
                HStack(spacing: 10) {
                    ForEach(character.urls, id: \.self) { data in
                        NavigationLink {
                            WebView(url: extractURL(data: data))
                                .navigationTitle(extractURLType(data: data))
                        } label: {
                            Text(extractURLType(data:data))
                        }
                        
                    }
                }
                .padding(.bottom, 10)
                
            }
            Spacer(minLength: 0)
        }
        .frame(height: 150)
        .padding(.horizontal)
    }
    
    private func extractImage(data: URLData) -> URL {
        let path = data["path"] ?? ""
        let ext = data["extension"] ?? ""
        return URL(string: "\(path).\(ext)")!
    }
    
    private func extractURL(data: URLData) -> URL {
        let url = data["url"] ?? ""
        return URL(string: url)!
    }
    
    private func extractURLType(data: URLData) -> String {
        let type = data["type"] ?? ""
        return type.capitalized
    }
    
}

struct CharacterRowView_Previews: PreviewProvider {
    static var previews: some View {
        let char = Character(id: 1, name: "Name", description: "descript",
                             thumbnail: [:], urls: [[:]])
        CharacterRowView(character: char)
    }
}
