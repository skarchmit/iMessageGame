//
//  SceneLoader.swift
//  
//
//  Created by Sergey Karchmit on 9/6/20.
//

import SpriteKit

@available(iOS 12.0, *)
open class SceneWrapper {

    weak var delegate: MessagesVC?
    private var scene: Scene?

    public var players: Players = Players()
    public var game: GameProtocol?
    

    init(fileNamed: String){
        self.scene = Scene(fileNamed: fileNamed)
        self.scene!.gameDelegate = self
        
    }



}


@available(iOS 12.0, *)
final class Scene : SKScene {

    public weak var gameDelegate: SceneWrapper?

}
