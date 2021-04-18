//
//  Game.swift
//
//
//  Created by Sergey Karchmit on 9/12/20.
//

import Foundation

open class Game: Codable {
    private enum CodingKeys: CodingKey {
        case uuid, players, status
    }

    public var uuid: String = UUID().uuidString

    /// Automanaged by MessageVC for you, but you may set up different items as pleased
    open var players: Players = Players()

    open var status: GameStatus = .new

    /// CanSend the game only if it is your turn
    open var canSend: Bool {
        /// Can send should short curcuit if
        return players.count >= 2 && players.isYourTurn && status != .over
    }

    public func start() {
        status = .active
        players.next()
    }

    public func end() {
        status = .over
    }

    /// Required otherwise sub class will need to create it
    public init() {
        // emtpy on purpose
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uuid = try container.decode(String.self, forKey: .uuid)
        players = try container.decode(Players.self, forKey: .players)
        status = try container.decode(GameStatus.self, forKey: .status)
    }

    open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(players, forKey: .players)
        try container.encode(status, forKey: .status)
    }
}
