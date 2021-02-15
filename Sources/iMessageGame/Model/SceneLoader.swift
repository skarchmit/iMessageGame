//
//  File.swift
//
//
//  Created by Sergey Karchmit on 9/13/20.
//

import Foundation

@available(iOS 12.0, *)
public struct SceneLoader {
    public var fileNamed: String
    public var scene: Scene.Type
    public var type: SceneType
    private var _initializedScene: Scene?

    public init(fileNamed: String, scene: Scene.Type, type: SceneType) {
        self.fileNamed = fileNamed
        self.scene = scene
        self.type = type
    }

    public mutating func initialize() -> Scene {
        if _initializedScene == nil {
            log.info("[SceneLoader] Initializing scene \(type)")
            _initializedScene = scene.init(fileNamed: fileNamed)!
        }
        return _initializedScene!
    }
}

@available(iOS 12.0, *)
extension SceneLoader: Equatable {
    public static func == (lhs: SceneLoader, rhs: SceneLoader) -> Bool {
        return lhs.type == rhs.type
    }
}
