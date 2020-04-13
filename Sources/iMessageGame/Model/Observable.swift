//
//  File.swift
//  
//
//  Created by Sergey Karchmit on 4/10/20.
//

import Foundation

/// For Views
public protocol Observer {
	var observable: Observable? {get set}
	func update()
}

/// For Models
public protocol Observable {
	public var observer: Observer?
}
