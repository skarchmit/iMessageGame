//
//  Observer.swift
//  
//
//  Created by Sergey Karchmit on 4/10/20.
//

import Foundation

/// For Views
public protocol Observer: Codable {
	/// the value that will can be refefrenced in the class
	var observable: Observable? {get set}
	func update()
}

/// For Models
public protocol Observable: Codable {
	/// where to send the update to
	var observer: Observer? { get set }
}
