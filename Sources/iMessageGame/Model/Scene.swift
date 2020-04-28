//
//  Scene.swift
//  
//
//  Created by Sergey Karchmit on 4/10/20.
//

import Foundation
import SpriteKit

//@available(iOS 12.0, *)
open class Scene: SKScene {
	
	public var game: GameProtocol
	
	public init(size: CGSize, game: GameProtocol) {
		self.game = game
		super.init(size: size)
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
//	override public init(fileNamed: String) {
//		super.init(fileNamed: fileNamed)!
//	}
//
//	override init
	
}

public protocol SceneProtocol {
	var game: GameProtocol { get set }
	func update()
}
