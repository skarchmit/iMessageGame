//
//  Scene.swift
//  
//
//  Created by Sergey Karchmit on 4/10/20.
//

import Foundation
import SpriteKit

public class Scene: SKScene {
	
	public var game: Game
	
	public init(size: CGSize, game: Game) {
		self.game = game
		super.init(size: size)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
