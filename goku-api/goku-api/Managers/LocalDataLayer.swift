//
//  LocalDataLayer.swift
//  goku-api
//
//  Created by Davina Medina Ramirez on 23/12/22.
//

import Foundation

final class LocalDataLayer {
    
    private static let token = "token"
    private static let heroes = "heroes"
    
    static let shared = LocalDataLayer()
    
    // Token
    
    func save(token: String) {
        return UserDefaults.standard.set(token, forKey: Self.token)
    }
    
    func getToken() -> String {
        return UserDefaults.standard.string(forKey: Self.token) ?? ""
    }
    
    func isUserLogged() -> Bool {
        return !getToken().isEmpty
    }
    
    func save(heroes: [Heroe]) {
        if let encodedHeroes = try? JSONEncoder().encode(heroes) {
            UserDefaults.standard.set(encodedHeroes, forKey: Self.heroes)
        }
    }
    
    func getHeroes() -> [Heroe] {
        if let savedHeroesData = UserDefaults.standard.object(forKey: Self.heroes) as? Data {
            do {
                let savedHeroes = try JSONDecoder().decode([Heroe].self, from: savedHeroesData)
                return savedHeroes
            } catch {
                print("Something went wrong !!!")
                return []
            }
        } else {
            return []
        }
    }
    
}
