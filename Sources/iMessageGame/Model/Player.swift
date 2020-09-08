//
//  Player.swift
//
//
//  Created by Sergey Karchmit on 4/10/20.
//

import Foundation

public class Player: Codable {
    private enum CodingKeys: String, CodingKey {
        // use
        case name
        case isCurrentTurn = "isCurrTurn"
    }

    public var observer: Any?

    public var name: String = "Player"

    // helper variables for the observer to use
    public var isCurrentTurn: Bool = false

    public init(name: String = "Player") {
        self.name = name
    }
}
