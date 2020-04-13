//
//  Players.swift
//  
//
//  Created by Sergey Karchmit on 4/10/20.
//

import Foundation

public class Players: RandomAccessCollection, Sequence  {
	
	/// Properties of RandomAccessCollection
	public var startIndex: Int
	public var endIndex: Int

	/// Properties of the collection, players
	private var _players = [Player]()
	private var _max: Int
	
	/// symlinks to the  players
	public var you: Player!			/// quick access to yourself
	public var current: Player!		/// quick access to the current player
	
	/// Quick access to see if it your turn; should be the same as you.isCurrentTurn
	public var isYourTurn: Bool {
		return you == current
	}
	
	/// bool variable to block adding more players for any reason; like game has started etc.
	public var canAddMore: Bool = true
	
	/// Init the players
	/// - Parameter max: Maximum players of the game
	init(max: Int = 2){
		startIndex = 0
		endIndex = _players.count
		_max = max
	}
	
	
	/// URLQueryItems prepackaged for exporting
	public var URLQueryItems: [URLQueryItem] {
		var items = [URLQueryItem]()
		
		for player in _players {
			items.append(URLQueryItem(name: "player", value: player.uuid))
		}
		
		items.append(URLQueryItem(name: "current", value: "\(current.uuid)"))
		
		return items
		
	}
	
	public func update(from URLQueryItems: [URLQueryItem]) {
		
		for queryItem in URLQueryItems {
			if queryItem.name == "player" {
				// attempt to add the player if they do not exist yet
				let _ = add(uuid: queryItem.value!)
				
			} else if queryItem.name == "current" {
				setCurrent(toPlayerWithUuid: queryItem.value!)
			}
		}
		
		logger.info("Players updated")
		
	}
	
	
	/// Add a player to the players, but do not go over the max
	/// - Parameter uuid: the UUID of the player
	/// - Returns: if player was added successfuly
	public func add(uuid: String) -> Player? {
		
		// dont add more than max amount of players
		if (
			_players.count == _max || 				/// dont add if player already exists
			!canAddMore ||							/// dont add if you cannot add any more
			_players.map({$0.uuid}).contains(uuid) 	/// dont add if player already exists
			) {
			return nil
			
		}
		
		let newPlayer = Player(uuid: uuid)

		_players.append(newPlayer)
	
		
		endIndex += 1
		
		return newPlayer
	}
	
	
	/// accessibility of Players info at position
	public subscript(_ position: Int) -> Player {
		return _players[position]
	}
	
	
	private func setCurrent(player: Player?) {
	
		if player == nil {
			logger.error("unable to set player as current")
			return
		}

		logger.info("setting current player to \(player!.uuid)")
		
		for i in startIndex..<endIndex {
			
			if player == _players[i] {
				_players[i].isCurrentTurn = true
				logger.info("setting player \(player!.uuid) isCurrentTurn to true")
				
			} else {
				_players[i].isCurrentTurn = false
				logger.info("setting player \(player!.uuid) isCurrentTurn to false")
			}
		}
	
		current = player
	}
	
	/// set the current player by searching the UUID
	/// - Parameter uuid: UUID String to search and set as the current player; if uuid string is not found, then no player is set
	internal func setCurrent(toPlayerWithUuid uuid: String) {
		
		var p: Player?
		
		for player in _players {
			if player.uuid == uuid {
				p = player
				break
			}
		}
		
		setCurrent(player: p)
	}
	
	
	
	/// Switch to the next player
	/// sets up isCurrentTurn in the player for sprite to get updates
	public func next(){
		
		setCurrent(player: current.next)
		
		logger.info("Next player set to: \(String(describing: current.uuid)), isCurrentTurn\(current.isCurrentTurn)")
		
	
	}

	
	/// Randomizes the list of players
	public func randomize() {
		// TODO: Randomize the array
		// TODO: change the next/previous to be in the new order
	}
	
	
	
	/// Get a random player
	/// - Returns: returns a random player
	/// - Parameter includeYourself: Should the ranom player be yourself?
	public func random(includeYourself: Bool = false) -> Player {
		// TODO: Return a random Player
		// TODO: Check if the random player is included and return a different one
		return Player(uuid: "")
	}
	

	
}
