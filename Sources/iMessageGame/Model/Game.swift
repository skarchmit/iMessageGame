//
//  Game.swift
//
//
//  Created by Sergey Karchmit on 9/12/20.
//

import Foundation

open class Game: Codable {
    /// Automanaged by MessageVC for you, but you may set up different items as pleased
    open var players: Players = Players()

    /// Override these variables to set up the game
    open var isOver: Bool = false

    /// Required otherwise sub class will need to create it
    public init() {}
}
