//
//  GameSettings.swift
//  StarWars
//
//  Created by Dmitriy on 21.08.2023.
//

import Foundation

struct GameSettings {
    static let shared = GameSettings()

    private let userDefaults = UserDefaults.standard

    var indexStarship: Int? {
        get {
            return userDefaults.integer(forKey: .indexStarship)
        }
        set {
            userDefaults.set(newValue, forKey: .indexStarship)
        }
    }
    
    var nameStarship: String? {
        get {
            return userDefaults.string(forKey: .nameStarship)
        }
        set {
            userDefaults.set(newValue, forKey: .nameStarship)
        }
    }

    var namePlayer: String? {
        get {
            return userDefaults.string(forKey: .namePlayer)
        }
        set {
            userDefaults.set(newValue, forKey: .namePlayer)
        }
    }

    var speedGame: Int? {
        get {
            return userDefaults.integer(forKey: .speedGame)
        }
        set {
            userDefaults.set(newValue, forKey: .speedGame)
        }
    }
}
