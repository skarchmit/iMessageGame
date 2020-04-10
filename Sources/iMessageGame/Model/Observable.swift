//
//  File.swift
//  
//
//  Created by Sergey Karchmit on 4/10/20.
//

import Foundation

public protocol Observer {
	func update()
}

public class Observable {
	public var observer: Observer?
}
