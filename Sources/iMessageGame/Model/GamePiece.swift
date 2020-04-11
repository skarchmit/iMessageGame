//
//  GamePiece.swift
//  
//
//  Created by Sergey Karchmit on 4/10/20.
//

import Foundation

public class GamePiece: GamePieceRepresentable {
	
	public static var name: String = ""
	public static var value: String = ""
	

	public var queryItem: URLQueryItem {
		get {
			return URLQueryItem(name: Self.name, value: Self.value)
		}
	}
	
}

extension GamePieceRepresentable where Self: GamePiece {
	
	var queryItem: URLQueryItem {
		return URLQueryItem(name: Self.name, value: Self.value)
	}
	
}

public protocol GamePieceRepresentable {
	static var name: String { get }
	static var value: String { get }
	var queryItem: URLQueryItem { get }

}
