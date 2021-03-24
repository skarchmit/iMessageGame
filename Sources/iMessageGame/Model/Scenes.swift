//
//  SceneManager.swift
//
//
//  Created by Sergey Karchmit on 9/7/20.
//

import SpriteKit

@available(iOS 12.0, *)
open class SceneManager {
    private var _active, _new: SceneLoader?

    public var current: Scene?
    private var _currentSceneLoader: SceneLoader? {
        didSet(oldValue) {
            /// Only initialize if changed
            if oldValue != _currentSceneLoader {
                // TODO: Somehow kill the other scene?
                current = _currentSceneLoader?.initialize()
            }
        }
    }

    public func add(_ sceneLoader: SceneLoader) {
        if sceneLoader.type == .active {
            _active = sceneLoader
        } else if sceneLoader.type == .new {
            _new = sceneLoader
        }
    }

    public func requestScene(sceneType: SceneType) {
        var curr: SceneLoader {
            switch sceneType {
            case .active:
                return _active!

            default:
                return _new!
            }
        }
        _currentSceneLoader = curr
    }
}
