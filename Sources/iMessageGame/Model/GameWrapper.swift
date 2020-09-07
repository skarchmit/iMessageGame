//
//  Game.swift
//
//
//  Created by Sergey Karchmit on 4/10/20.
//

import Foundation
import Messages

open class GameWrapper {
	
	public var players: Players = Players()
	
	public var game: GameProtocol?
	
	public var URL: URL {
		
		var items = [URLQueryItem]()
		var components = URLComponents()
		
		
		// TODO add players URLQueryItems
		//items.append(contentsOf: players.URLQueryItems)
		
		if let g = game {
			items.append(contentsOf: g.URLQueryItems)
		}
		
		
		components.queryItems = items
		return components.url!
	}
	
	public init (game: GameProtocol? = nil) {
		self.game = game
	}
	
}


extension GameWrapper {
	
	/// Update the game from the message recieved
	/// - Parameter message: The message used to update all the game Items
	@available(iOS 10.0, *)
	public func update(fromMessage message: MSMessage) {
		
	}
	
}
