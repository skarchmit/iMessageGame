//
//  PlayerWrapper.swift
//
//
//  Created by Sergey Karchmit on 4/12/20.
//

import Foundation

/// Player information to be hidden away from the main interface
class PlayerWrapper: Codable {
    private enum CodingKeys: String, CodingKey {
        // use
        case uuid
        case player
        case next
        case previous = "prev"
    }

    /// UUID to identify if the player is already in the game
    public var uuid: String

    /// This player
    public var player: Player

    /// absorbed value
    public var isCurrentTurn: Bool {
        return player.isCurrentTurn
    }

    /// Next / Previous players
    public weak var next: PlayerWrapper!
    public weak var previous: PlayerWrapper!

    ///
    init(player: Player, uuid: String) {
        self.player = player
        self.uuid = uuid
    }
}

extension PlayerWrapper: Hashable {
    public static func == (lhs: PlayerWrapper, rhs: PlayerWrapper) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
