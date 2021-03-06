//
//  File.swift
//
//
//  Created by Sergey Karchmit on 9/7/20.
//

import SpriteKit

@available(iOS 12.0, *)
open class Scene: SKScene {
    /// Delegate to obtain send back to the scene
    public weak var gameDelegate: iMessageGame.MessagesVC?

    open var game: iMessageGame.Game!
}
 
