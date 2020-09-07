//
//  SceneLoader.swift
//  
//
//  Created by Sergey Karchmit on 9/6/20.
//

import SpriteKit

@available(iOS 12.0, *)
open class SceneDelegate {

    /// Delegate back to MessagesVC
    public weak var delegate: MessagesVC?
    
    /// Scene Object that is being wrapped
    private var scene: Scene?

    public init(fileNamed: String){
        self.scene = Scene(fileNamed: fileNamed)
        self.scene!.gameDelegate = self
        
    }
    
    public init(skscene: SKScene){
        self.scene = skscene as? Scene
        self.scene!.gameDelegate = self
        
    }
    
    public init(scene: Scene){
        self.scene = scene
        self.scene!.gameDelegate = self
        
    }
    
    open func send(caption: String, summaryText: String, withConfirmation: Bool) {
        let message = delegate?.composeMessage(caption: caption, summaryText: summaryText)
        delegate?.send(message: message!, withConfirmation: withConfirmation)
    }



}


@available(iOS 12.0, *)
open class Scene : SKScene {

    /// Delegate to obtain send back to the scene
    public weak var gameDelegate: SceneDelegate?
    
    /// Variables for use to interact
    public var players: Players?
    public var game: GameProtocol?

}
