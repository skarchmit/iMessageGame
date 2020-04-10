//
//  Player.swift
//  
//
//  Created by Sergey Karchmit on 4/10/20.
//

import Foundation

public class Player: Observable {

	public var uuid: String
	
	public init(uuid: String) {
		self.uuid = uuid
	}

}

extension Player: Hashable{
	public static func == (lhs: Player, rhs: Player) -> Bool {
		return lhs.uuid == rhs.uuid
	}
	
	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.uuid)
	}
}
