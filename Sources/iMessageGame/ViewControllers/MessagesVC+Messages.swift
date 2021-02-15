//
//  File.swift
//
//
//  Created by Sergey Karchmit on 9/12/20.
//

import Foundation
import Messages

@available(iOS 12.0, *)
extension MessagesVC {
    /// Creates a message from the parameters
    /// - Parameters:
    ///   - game: the game to send
    ///   - caption: caption for the messge
    ///   - session: current session
    /// - Returns: Generated MSMessage
    private func composeMessage(caption: String, summaryText: String = "Sent Message") -> MSMessage {
        let layout = MSMessageTemplateLayout()
        let _session = session ?? MSSession()
        layout.caption = caption

        let message = MSMessage(session: _session)

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
        if withConfirmation {
            sendWithCofirmation(message: message)
        } else {
            sendWithoutCofirmation(message: message)
        }
    }

    private func sendWithCofirmation(message: MSMessage) {
        guard let conversation = activeConversation else { fatalError("Conversation Expected") }
        conversation.insert(message) { error in
            if let error = error {
                log.error("Error in sending message")
                log.error("\(error)")
            }
        }
        requestPresentationStyle(.compact)
    }

    private func sendWithoutCofirmation(message: MSMessage) {
        guard let conversation = activeConversation else { fatalError("Conversation Expected") }
        conversation.send(message) { error in
            if let error = error {
                log.error("Error in sending message")
                log.error("\(error)")
            }
        }
    }

    open func send(caption: String, summaryText: String, withConfirmation: Bool, injectCurrentPlayer: Bool = false) {
        let message = composeMessage(caption: caption, summaryText: summaryText)
        guard let game = sceneManager.current?.game else { return }

        let game2: Game
        if injectCurrentPlayer {
            game2 = setUpCurrentPlayersInSession(game: game)
        } else {
            game2 = game
        }
        guard let gameUrl = serializeGame(game: game2) else { return }
        message.url = gameUrl
        send(message: message, withConfirmation: withConfirmation)
        log.info("Successfully sent message.")
    }
}
