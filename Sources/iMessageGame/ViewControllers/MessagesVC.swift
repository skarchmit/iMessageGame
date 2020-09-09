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
    public var scenes: Scenes?

    /// One game accessed by all
    public var gameWrapper: GameWrapper = GameWrapper()

    public var game: GameWrapper?

    public var players: Players = Players()

    /// Yourself
    public var you: Player!

    //	private var _scene: Scene!

//    private var _sceneDelegate: SceneDelegate?

    /// Window Managers
    private var _skview: SKView!
    private var _session: MSSession?
    private var _activeConversation: MSConversation?

//    /// Different types of scenes to switch between
    //	open var newGameScene: Scene?
    //	open var lobbyGameScene: Scene?
//    open var activeGameScene: Scene?
//    open var endGameScene: Scene?

    override open func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
        if let skview = view as? SKView {
            _skview = skview
            _skview.showsFPS = true
            _skview.showsNodeCount = true
            _skview.ignoresSiblingOrder = true
            print("skview initialized")
        }
        manageScenes()
    }

    /// When the view appears, we get to see all the participants of the game
    /// - Parameter animated: animated
    override open func viewWillAppear(_ animated: Bool) {
        // get information about the active converstation

        players = Players()

        you = players.add(uuid: (activeConversation?.localParticipantIdentifier.uuidString)!)

        for remoteParticipantIdentifier in activeConversation!.remoteParticipantIdentifiers {
            print("Player", remoteParticipantIdentifier.uuidString)
        }
    }

    private func manageScenes(message: MSMessage? = nil) {
        var currentScene: Scene

        if let m = message, presentationStyle == .expanded {
            // TODO: Extract m JSON, fill in the scene
            currentScene = scenes!.requestScene(sceneType: .active)

        } else {
            currentScene = scenes!.requestScene(sceneType: .new)
        }

//        self._sceneWrapper?.delegate = self
//        self._sceneWrapper?.scene.scaleMode = .aspectFill

        currentScene.gameDelegate = self
        currentScene.scaleMode = .aspectFill

        print("Presenting scene")
//        _skview.presentScene(self._scene)

        _skview.presentScene(currentScene)
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

@available(iOS 12.0, *)
extension MessagesVC {
    /// Creates a message from the parameters
    /// - Parameters:
    ///   - game: the game to send
    ///   - caption: caption for the messge
    ///   - session: current session
    /// - Returns: Generated MSMessage
    private func composeMessage(caption: String, summaryText: String = "Sent Message") -> MSMessage {
        let session = _session ?? MSSession()

        let layout = MSMessageTemplateLayout()
        layout.caption = caption

        let message = MSMessage(session: session)
        message.url = game?.URL
        message.layout = layout
        message.summaryText = summaryText

        return message
    }

    /// Sends Message by inserting into conversation
    /// - Parameters:
    ///   - message: MSMessage to send
    ///   - conversation: the conversation to inject the message into
    ///   - withConfirmation: whether the user must confirm to send
    open func send(message: MSMessage, withConfirmation: Bool) {
        let conversation = _activeConversation ?? MSConversation()

        if withConfirmation {
            sendWithCofirmation(message: message)
        } else {
            sendWithoutCofirmation(message: message)
        }
    }

    private func sendWithCofirmation(message: MSMessage) {
        guard let conversation = self.activeConversation else {fatalError("Conversation Expected")}
        conversation.insert(message) { error in
            if let error = error {
                print("Error in sending message")
                print(error)
            }
        }
    }

    private func sendWithoutCofirmation(message: MSMessage) {
        guard let conversation = self.activeConversation else {fatalError("Conversation Expected")}
        conversation.send(message) { error in
            if let error = error {
                print("Error in sending message")
                print(error)
            }
        }
    }

    open func send(caption: String, summaryText: String, withConfirmation: Bool) {
        // TODO: wrap game
        let game = scenes?.current?.game
        let message = composeMessage(caption: caption, summaryText: summaryText)
        send(message: message, withConfirmation: withConfirmation)
    }
}
