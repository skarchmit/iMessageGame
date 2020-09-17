//
//  Player.swift
//
//
//  Created by Sergey Karchmit on 4/10/20.
//

import Foundation

public struct Player: Codable {

    private var uuidString: String?
    public var name: String
    public var score: Int = 0

    public init(name: String = "Player", uuidString: String = "") {
        self.name = name
        self.uuidString = uuidString
    }
    
    public mutating func incrementScore(by value: Int = 1) {
        score += value
    }
}
