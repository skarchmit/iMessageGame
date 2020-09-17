//
//  File.swift
//
//
//  Created by Sergey Karchmit on 9/12/20.
//

import Foundation

open class Game: Codable {
    /// Automanaged by MessageVC for you, but you may set up different items as pleased
    open var players: String?

    /// Override these variables to set up the game
    open var isOver: Bool = false
    
    public init () {
        
    }
    
}