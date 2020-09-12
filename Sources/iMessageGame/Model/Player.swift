//
//  Player.swift
//
//
//  Created by Sergey Karchmit on 4/10/20.
//

import Foundation

public struct Player: Codable {

    private var uuid: String
    public var name: String = "Player"

    public init(name: String = "Player", uuid: String) {
        self.name = name
        self.uuid = uuid
    }
}
