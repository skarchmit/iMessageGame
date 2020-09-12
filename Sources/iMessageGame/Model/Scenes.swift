//
//  File.swift
//
//
//  Created by Sergey Karchmit on 9/7/20.
//

import SpriteKit

@available(iOS 12.0, *)
open class Scenes {
    private var active, end, new, lobby: Scene?
    public var current: Scene?

    public init(active: Scene? = nil, end: Scene? = nil, new: Scene? = nil, lobby: Scene? = nil) {
        self.active = active
        self.end = end
        self.new = new
        self.lobby = lobby
    }

    public func requestScene(sceneType: SceneType) {
        switch sceneType {
        case .active:
            self.current = active!

        case .end:
            self.current =  end ?? new!

        default:
            self.current =  new!
        }
    }
}
