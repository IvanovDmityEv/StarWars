//
//  Results.swift
//  StarWars
//
//  Created by Dmitriy on 24.08.2023.
//

import Foundation

import Foundation

struct ResultPlayer: Codable {
    let name: String
    let starship: String
    let gamePoints: Int
}

struct ResultsGame {
    static func saveResult(_ result: ResultPlayer) {
        var existingResults = getResults()
        existingResults.append(result)
        let encodedResults = try? JSONEncoder().encode(existingResults)
        UserDefaults.standard.set(encodedResults, forKey: .arrayResultKey)
    }

    static func getResults() -> [ResultPlayer] {
        if let encodedResults = UserDefaults.standard.data(forKey: .arrayResultKey) {
            if let decodedResults = try? JSONDecoder().decode([ResultPlayer].self, from: encodedResults) {
                return decodedResults
            }
        }
        return []
    }
}
