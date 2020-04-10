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
	
	private var gameScene: GameScene?
	private var lobbyScene: LobbyScene?
	private var newGameScene: NewGameScene?
	

	override func viewDidLoad() {
		super.viewDidLoad()
		
		/// Add yourself to the players
		you = Player(uuid: activeConversation!.localParticipantIdentifier.uuidString)
		
	}
	
	override public func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		
		/// Load the appropriate scene
	}
	
	private func manageScenes(message: MSMessage? = nil) {
		if let m = message, presentationStyle == .expanded {
			// load gameScene / lobbyScene
		} else {
			// load newGameScene
		}
	}
	
	private func updateGame(with message: MSMessage) {
		// Make a new game
		if game == nil { game = Game() }
	
	}
	
	
}
