//
//  Players.swift
//
//
//  Created by Sergey Karchmit on 4/10/20.
//

import Foundation

public class Players: RandomAccessCollection, Sequence, Codable {
    /// Minimum and Maximum players in game
    public var max: Int
    public var min: Int

    /// Quick accessors to get instance of Player
	// TODO:Check if we need to always work with the index
    public var current: Player { return _players[_currentPlayerIndex] }
    public var yourself: Player { return _players[_yourselfPlayerIndex] }
    public var isYourTurn: Bool {
        return current == yourself
    }

    /// MessagesVC will inject yourself as the player when we instantiate the game
    /// So we are guaranteed to have one player and therefore
    /// current and yourself will be successful calls
    /// But in order to send game
    private var _players: [Player] = [Player]()

    /// The game.canSend property will short curcuit before looking
    /// at the _currentPlayerIndex if we dont have 2 players
    private var _currentPlayerIndex: Int = 0
    private var _yourselfPlayerIndex: Int = 0

    /// RandomAccessCollection required variables
    public var startIndex: Int
    public var endIndex: Int

    init(min: Int = 2, max: Int = 2) {
        self.max = max
        self.min = min
        startIndex = 0
        endIndex = 0
    }

    /// Random Access
    public subscript(_ position: Int) -> Player {
        return (_players[position])
    }

    /// Add a single player
    /// If player already exists, then it will replace with the current data
    public func add(_ player: Player) {
        if _players.contains(player) {
            log.info("Player already exists")
            return
        }
        if endIndex == max {
            log.error("Cannot add more players")
        } else {
            _players.append(player)
            endIndex += 1
            log.info("Added a new player: \(player.uuid)")
        }
    }

    public func setYourselfPlayer(uuid: String) {
        for (index, player) in _players.enumerated() {
            if player.uuid == uuid {
                player.isOpponent = false
                _yourselfPlayerIndex = index
                break
            }
        }
    }

    public func next() {
        _currentPlayerIndex = (_currentPlayerIndex + 1) % endIndex
        updatePlayerVariables()
    }

    public func previous() {
        _currentPlayerIndex = (_currentPlayerIndex - 1) % endIndex
        updatePlayerVariables()
    }

    public func updatePlayerVariables() {
        for player in _players {
            player.isCurrentTurn = player == current
        }
    }
}

extension Players: CustomStringConvertible {
    public var description: String {
        let uuids = _players.map { $0.uuid }
        let joinedUuids = uuids.joined(separator: ", ")
        return joinedUuids
    }
}
