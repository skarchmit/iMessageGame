//
//  Players.swift
//
//
//  Created by Sergey Karchmit on 4/10/20.
//

import Foundation

public class Players: RandomAccessCollection, Sequence, Codable {
    /// Minimum and Maximum players in game
    public var max: Int = 2
    public var min: Int = 2

    public var current: Player?
    public var yourself: Player?

    private var _players: [Player] = [Player]()
    private var _currentPlayerIndex: Int = 0

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

    public func add(_ player: Player) {
        if endIndex == max {
            print("cannot add more players")
            // throw Error
        } else {
            _players.append(player)
            endIndex += 1
        }
    }

    public func add(_ players: [Player]) {
        for player in players {
            add(player)
        }
    }

    public func next() {
        _currentPlayerIndex = (_currentPlayerIndex + 1) % endIndex
    }
}
