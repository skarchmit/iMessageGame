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
	
	private var scene: Scene!
	private var skview: SKView!

	open override func viewDidLoad() {
		super.viewDidLoad()	}
	
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
	
	
	private func manageScenes(message: MSMessage? = nil) {
		if let m = message, presentationStyle == .expanded {
			/// update game
			gameWrapper.update(fromMessage: m)
			
			/// load gameScene / lobbyScene as needed; if loaded already update is not necessary
			///
			
		} else {
			// load newGameScene
		}
	}
	
	
	internal func update(from message: MSMessage) {
		
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
