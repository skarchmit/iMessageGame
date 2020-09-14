//
//  File.swift
//
//
//  Created by Sergey Karchmit on 9/7/20.
//

import SpriteKit

@available(iOS 12.0, *)
open class SceneManager {
    open var active, end, new, lobby: SceneInfo?

    public var current: Scene? {
        didSet {
            if current != nil {
            }
        }
    }

    public func requestScene(sceneType: SceneType) {
        var curr: SceneInfo {
            switch sceneType {
            case .active:
                return active!

            case .end:
                return end ?? new!

            default:
                return new!
            }
        }

        current = curr.initialized
    }
}
