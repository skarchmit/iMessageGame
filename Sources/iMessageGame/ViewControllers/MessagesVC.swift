//
//  MessagesVC.swift
//  
//
//  Created by Sergey Karchmit on 4/10/20.
//

import Messages
import SpriteKit

@available(iOS 10.0, *)
open class MessagesVC: MSMessagesAppViewController {
	
	/// One game accessed by all
	public var gameWrapper: GameWrapper = GameWrapper()
	
	public var game: GameProtocol?
	
	public var players: Players = Players()
	
	/// Yourself
	public var you: Player!
	
	private var _scene: SKScene!
	private var _skview: SKView!
	
	open var newGameScene: SKScene!
	open var lobbyGameScene: SKScene!
	open var gameScene: SKScene!
	
	

	open override func viewDidLoad() {
		super.viewDidLoad()
		print ("viewDidLoad")
		if let skview = self.view as? SKView {
			self._skview = skview
			_skview.showsFPS = true
			_skview.showsNodeCount = true
			_skview.ignoresSiblingOrder = true
			print ("skview initialized")
		}
		
		manageScenes()
	}
	
	/// When the view appears, we get to see all the participants of the game
	/// - Parameter animated: animated
	open override func viewWillAppear(_ animated: Bool) {
		
		// get information about the active converstation
		
		players = Players()
		
		you = players.add(uuid: (activeConversation?.localParticipantIdentifier.uuidString)!)
		
		
		for remoteParticipantIdentifier in activeConversation!.remoteParticipantIdentifiers {
			print (remoteParticipantIdentifier.uuidString)
		}
	}
	
	open override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
	
	
	private func manageScenes(message: MSMessage? = nil) {
		print ("Manage Scenes")
		
		self._scene = nil
		
		if let m = message, presentationStyle == .expanded {
			/// update game
			gameWrapper.update(fromMessage: m)
			
			/// load gameScene / lobbyScene as needed; if loaded already update is not necessary
			/// TODO: put logic in here
				
			self._scene = self.gameScene //as! Scene
			
		} else {
			/// load newGameScene
			self._scene = self.newGameScene //as! Scene
		}
		
		self._scene.scaleMode = .aspectFill
		
		print("Presenting scene")
		_skview.presentScene(self._scene)
		
		
	}
	
	
	internal func update(from message: MSMessage) {
		
	}
	
	
	// MARK: - Messages Entry Points
	open override func willBecomeActive(with conversation: MSConversation) {
		super.didBecomeActive(with: conversation)
		
		// request an enlarged view if we got a message;
		// the transition to will take care of managing views
		if conversation.selectedMessage != nil {
			requestPresentationStyle(.expanded)
		} else {
			manageScenes()
		}
		
	}
	
	
	/**
	Runs only when the extension is active
	*/
	open override func willSelect(_ message: MSMessage, conversation: MSConversation) {
		super.willSelect(message, conversation: conversation)
		requestPresentationStyle(.expanded)
	}
	
	open override func didSelect(_ message: MSMessage, conversation: MSConversation) {
		super.didSelect(message, conversation: conversation)
		manageScenes(message: message)
	}
	
	/**
	When extension is open, do this when you receive the message
	refresh the game by managing views
	*/
	open override func didReceive(_ message: MSMessage, conversation: MSConversation) {
		super.didReceive(message, conversation: conversation)
		manageScenes(message: message)
	}
	

	
	open override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
		super.didTransition(to: presentationStyle)
		manageScenes(message: activeConversation?.selectedMessage)
	}
}



@available(iOS 10.0, *)
extension MessagesVC {
	
	/// Creates a message from the parameters
	/// - Parameters:
	///   - game: the game to send
	///   - caption: caption for the messge
	///   - session: current session
	/// - Returns: Generated MSMessage
	public func composeMessage(with gameWrapper: GameWrapper, caption: String, session: MSSession = MSSession(), summaryText: String = "Sent Message") -> MSMessage {
		
		let layout = MSMessageTemplateLayout()
		layout.caption = caption
		
		let message = MSMessage(session: session)
		message.url = gameWrapper.URL
		message.layout = layout
		message.summaryText = summaryText
		
		return message
	}
	
	
	/// Sends Message by inserting into conversation
	/// - Parameters:
	///   - message: MSMessage to send
	///   - conversation: the conversation to inject the message into
	///   - withConfirmation: whether the user must confirm to send
	@available(iOS 11.0, *)
	public func send(message: MSMessage, into conversation: MSConversation, withConfirmation: Bool){
		
		print ("sending")
		if withConfirmation {
			
			conversation.insert(message) { error in
				if let error = error {
					print(error)
				}
			}
		} else {
			conversation.send(message) { (error) in
				if let error = error {
					print (error)
				}
			}
		}
	}
	
}
