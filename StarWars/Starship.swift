//
//  Starship.swift
//  StarWars
//
//  Created by Dmitriy on 28.07.2023.
//

import Foundation


class Starship {
    
    var positionX: Int
    var positionY: Int
    var width: Int
    var height: Int
    var name: String
    
    init(positionX: Int, positionY: Int, width: Int, height: Int, nameStarship: String) {
        self.positionX = positionX
        self.positionY = positionY
        self.width = width
        self.height = height
        self.name = nameStarship
    }
}




