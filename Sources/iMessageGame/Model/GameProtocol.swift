//
//  File.swift
//  
//
//  Created by Sergey Karchmit on 4/11/20.
//

import Foundation

public protocol GameProtocol {
	
	init()
	
	var URLQueryItems: [URLQueryItem] { get set }
	
	func update(from queryItems: [URLQueryItem])
	
}
