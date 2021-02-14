//
//  MessagesVC.swift
//
//
//  Created by Sergey Karchmit on 4/10/20.
//

import Logging
import Messages
import SpriteKit

@available(iOS 12.0, *)
open class MessagesVC: MSMessagesAppViewController {
    /// Scenes Manager
    public var sceneManager: SceneManager = SceneManager()

    /// Instantiating a specific subclass of a game
    open var gameType: Game.Type = Game.self
    open var playerType: Player.Type = Player.self

    /// Window Managers
    internal var _skview: SKView!
    internal var _session: MSSession?

    override open func viewDidLoad() {
        super.viewDidLoad()
        if let skview = view as? SKView {
            _skview = skview
            _skview.showsFPS = false
            _skview.showsNodeCount = false
            _skview.ignoresSiblingOrder = true
        }
        manageScenes()
    }

    internal func setUpCurrentPlayersInSession(game: Game) -> Game {
        // get information about the active converstation
        // TODO: Get player information
        // This would work best with iCloud storage for avatars etc.

        log.info("Setting up game's players")

        /// Recreate yourself, TODO: Pull this information from cloud saves instead of building it here
        let yourUuid = activeConversation!.localParticipantIdentifier.uuidString
        let yourself = Player(name: "You", uuidString: yourUuid)

        game.players.add(yourself)

        /// Must call these in order to make game.players.current and game.players.yourself
        /// be a reference instead of a copy
        game.players.setYourselfPlayer(uuid: yourUuid)

        return game
    }

    private func manageScenes(message: MSMessage? = nil) {
        if let m = message, presentationStyle == .expanded, let game = deserializeGame(url: m.url) {
            sceneManager.requestScene(sceneType: .active)

            let injectedGame = setUpCurrentPlayersInSession(game: game)
            sceneManager.current?.game = injectedGame

        } else {
            sceneManager.requestScene(sceneType: .new)
        }

        sceneManager.current!.gameDelegate = self
        sceneManager.current!.scaleMode = .aspectFill

        _skview.presentScene(sceneManager.current)
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

     According to Apple's website:
     The system does not call this method if the controller’s presentationStyle property is MSMessagesAppPresentationStyle.transcript, or if its presentationContext property is MSMessagesAppPresentationContext.media.
     */
    override open func didReceive(_ message: MSMessage, conversation: MSConversation) {
        log.info("didReceive message \(presentationContext.rawValue)")
        super.didReceive(message, conversation: conversation)
        manageScenes(message: message)
    }

    override open func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        log.info("didTransition to \(presentationStyle.rawValue)")
        super.didTransition(to: presentationStyle)
        manageScenes(message: activeConversation?.selectedMessage)
    }

    /// Gets called at all times when you send out a message
    override open func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        super.didStartSending(message, conversation: conversation)
        manageScenes(message: activeConversation?.selectedMessage)
    }
}
