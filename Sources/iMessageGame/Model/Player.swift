//
//  Player.swift
//  
//
//  Created by Sergey Karchmit on 4/10/20.
//

import Foundation

public class Player: Observable {
	
	public var observer: Observer?
	
	public var name: String = "Player"
	
	// helper variables for the observer to use
	public var isCurrentTurn: Bool = false
	
	
	public init(name: String = "Player") {
		self.name = name
	}

}


