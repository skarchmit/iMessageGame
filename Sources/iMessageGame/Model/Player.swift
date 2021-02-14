//
//  Player.swift
//
//
//  Created by Sergey Karchmit on 4/10/20.
//

import Foundation

open class Player: Codable {
    public var uuid: String
    public var name: String
    public var score: Int = 0
    public var isOpponent: Bool = true

    public init(name: String = "Player", uuidString: String = "") {
        self.name = name
        uuid = uuidString
    }
}

extension Player: Equatable {
    public static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
