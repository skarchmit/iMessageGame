//
//  File.swift
//
//
//  Created by Sergey Karchmit on 9/13/20.
//

import Foundation

@available(iOS 12.0, *)
public struct SceneInfo {
    public var fileNamed: String
    public var scene: Scene.Type
    
    public init(fileNamed: String, scene: Scene.Type) {
        self.scene = scene
        self.fileNamed = fileNamed
    }
    
    public var initialized: Scene {
        return scene.init(fileNamed: fileNamed)!
    }
    
}
