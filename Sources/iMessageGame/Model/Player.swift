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
    public var isCurrentTurn: Bool = false

    public init(name: String = "Player", uuidString: String? = nil) {
        self.name = name
        uuid = uuidString ?? UUID().uuidString
    }
}

extension Player: Equatable {
    public static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
