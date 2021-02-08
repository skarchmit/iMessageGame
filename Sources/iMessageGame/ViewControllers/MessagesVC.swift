//
//  MessagesVC.swift
//
//
//  Created by Sergey Karchmit on 4/10/20.
//

import Messages
import SpriteKit

@available(iOS 12.0, *)
open class MessagesVC: MSMessagesAppViewController {
    /// Scenes Manager
    public var sceneManager: SceneManager = SceneManager()

    /// Instantiating a specific subclass of a game
    open var gameType: Game.Type = Game.self

    /// Window Managers
    internal var _skview: SKView!
    internal var _session: MSSession?
    internal var _activeConversation: MSConversation?

    override open func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
        if let skview = view as? SKView {
            _skview = skview
            _skview.showsFPS = false
            _skview.showsNodeCount = false
            _skview.ignoresSiblingOrder = true
            print("skview initialized")
        }
        manageScenes()
    }

    /// When the view appears, we get to see all the participants of the game
    /// - Parameter animated: animated
    override open func viewWillAppear(_ animated: Bool) {
        if _activeConversation != nil {
            setUpCurrentPlayersInSession()
        }
		super.viewWillAppear(animated)
    }

//	open override func viewDidAppear(_ animated: Bool) {
////        if _activeConversation != nil {
////            setUpCurrentPlayersInSession()
////        }
//    }

    private func setUpCurrentPlayersInSession() {
        // get information about the active converstation
        // TODO: Get player information
        // This would work best with iCloud storage for avatars etc.

        var playersInSession = [Player]()

        let yourUuid = _activeConversation!.localParticipantIdentifier.uuidString
        let yourselfPlayer = Player(name: "You", uuidString: yourUuid)
        playersInSession.append(yourselfPlayer)

        for playerUuid in _activeConversation!.remoteParticipantIdentifiers {
            let opponent = Player(name: "Opponent", uuidString: playerUuid.uuidString)
            playersInSession.append(opponent)
        }

        sceneManager.current?.playersInSession = playersInSession
        sceneManager.current?.yourUuid = yourUuid
    }

    private func manageScenes(message: MSMessage? = nil) {
        if let m = message, presentationStyle == .expanded, let game = deserializeGame(url: m.url) {
            /// Request the scene (instantiates it)
            sceneManager.requestScene(sceneType: .active)

            /// Pass in a deserialized game instance
            /// Job of the Scene class to parse with didChange
            sceneManager.current?.game = game
        } else {
            sceneManager.requestScene(sceneType: .new)
        }

        sceneManager.current!.gameDelegate = self
        sceneManager.current!.scaleMode = .aspectFill

        print("Presenting scene")
        _skview.presentScene(sceneManager.current)
    }

    internal func update(from message: MSMessage) {
    }

    // MARK: - Messages Entry Points

    override open func willBecomeActive(with conversation: MSConversation) {
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
    override open func willSelect(_ message: MSMessage, conversation: MSConversation) {
        super.willSelect(message, conversation: conversation)
        requestPresentationStyle(.expanded)
    }

    override open func didSelect(_ message: MSMessage, conversation: MSConversation) {
        super.didSelect(message, conversation: conversation)
        manageScenes(message: message)
    }

    /**
     When extension is open, do this when you receive the message
     refresh the game by managing views
     */
    override open func didReceive(_ message: MSMessage, conversation: MSConversation) {
        super.didReceive(message, conversation: conversation)
        manageScenes(message: message)
    }

    override open func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        super.didTransition(to: presentationStyle)
        manageScenes(message: activeConversation?.selectedMessage)
    }
}
