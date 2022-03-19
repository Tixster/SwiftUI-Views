//
//  HomeViewModel.swift
//  MarvelHeroes
//
//  Created by Кирилл Тила on 12.02.2022.
//

import SwiftUI
import Combine
import CryptoKit

class HomeViewModel: ObservableObject {
    
    private let publicKey = "a8c47879b9cb687d98c9afdfc87afd2f"
    private let privateKey = "b738de7b18641371b79e93e91176cb518a79f307"
    
    @Published var characterViewTitle = "Персонажи"
    
    @Published var searchQuery = ""
   
    @Published var fetchedCharacter: [Character]? = nil
    @Published var fetchedComics: [Comic] = []
    
    @Published var offset: Int = 0
    
    private var searchCancellable: Set<AnyCancellable> = []
    
    init() {
        $searchQuery
            .debounce(for: 0.6, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { str in
                guard !str.isEmpty else {
                    self.fetchedCharacter = nil
                    return
                }
                self.searchCharatcer()
            }
            .store(in: &searchCancellable)
    }
    
    func searchCharatcer() {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: ts + privateKey + publicKey)
        var components = URLComponents()
        components.scheme = "https"
        components.host = "gateway.marvel.com"
        components.port = 443
        components.path = "/v1/public/characters"
        let queryTS = URLQueryItem(name: "ts", value: ts)
        let queryPublickKey = URLQueryItem(name: "apikey", value: publicKey)
        let queryHash = URLQueryItem(name: "hash", value: hash)
        let originalQuery = searchQuery.replacingOccurrences(of: " ", with: "%20")
        let originalQueryItem = URLQueryItem(name: "nameStartsWith", value: originalQuery)
        components.queryItems = [originalQueryItem, queryTS, queryPublickKey, queryHash]
            
        URLSession.shared.dataTaskPublisher(for: components.url!)
            .map { $0.data }
            .decode(type: APIResult.self, decoder: JSONDecoder())
            .map { $0.data.results }
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    print("Всё ок! Данные пришли!")
                     break
                }
            }, receiveValue: { char in
                self.fetchedCharacter = char
            })
            .store(in: &searchCancellable)
    }
    
    func searchComics() {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: ts + privateKey + publicKey)
        var components = URLComponents()
        components.scheme = "https"
        components.host = "gateway.marvel.com"
        components.port = 443
        components.path = "/v1/public/comics"
        let limitQuery = URLQueryItem(name: "limit", value: "20")
        let offsetQuery = URLQueryItem(name: "offset", value: "\(offset)")
        let queryTS = URLQueryItem(name: "ts", value: ts)
        let queryPublickKey = URLQueryItem(name: "apikey", value: publicKey)
        let queryHash = URLQueryItem(name: "hash", value: hash)
        components.queryItems = [limitQuery, offsetQuery, queryTS, queryPublickKey, queryHash]
            
        URLSession.shared.dataTaskPublisher(for: components.url!)
            .map { $0.data }
            .decode(type: APIComicResult.self, decoder: JSONDecoder())
            .map { $0.data.results }
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    print("Всё ок! Данные пришли!")
                     break
                }
            }, receiveValue: { comics in
                self.fetchedComics.append(contentsOf: comics)
            })
            .store(in: &searchCancellable)
    }
    
    func MD5(data: String) -> String {
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        return hash.map {
            String(format: "%02hhx", $0)
        }
        .joined()
    }
    
}
