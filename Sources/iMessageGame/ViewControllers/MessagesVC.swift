//
//  MessagesVC.swift
//  
//
//  Created by Sergey Karchmit on 4/10/20.
//

import Messages
import SpriteKit

@available(iOS 10.0, *)
class MessagesVC: MSMessagesAppViewController {
	
	/// One game accessed by all
	public var game: Game = Game()
	
	/// Yourself
	public var you: Player!
	
	private var scene: SKScene!
	private var skview: SKView!

	override func viewDidLoad() {
		super.viewDidLoad()
		
		/// Add yourself to the players
		you = Player(uuid: activeConversation!.localParticipantIdentifier.uuidString)
		
	}

	
	private func manageScenes(message: MSMessage? = nil) {
		if let m = message, presentationStyle == .expanded {
			/// update game
			game.update(fromMessage: m)
			
			/// load gameScene / lobbyScene as needed; if loaded already update is not necessary
			///
			
		} else {
			// load newGameScene
		}
	}
	
	private func updateGame(with message: MSMessage) {
		
	}
	
	
}
