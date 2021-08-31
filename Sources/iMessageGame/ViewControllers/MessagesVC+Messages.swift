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
    open func send(message: MSMessage, withConfirmation: Bool) -> Bool {
        if withConfirmation {
            return sendWithCofirmation(message: message)
        } else {
            return sendWithoutCofirmation(message: message)
        }
    }

    private func sendWithCofirmation(message: MSMessage) -> Bool {
        guard let conversation = activeConversation else { fatalError("Conversation Expected") }
        var isSuccess = true
        conversation.insert(message) { error in
            if let error = error {
                log.error("Error in sending message \(error)")
                isSuccess = false
            }
        }
        requestPresentationStyle(.compact)
        return isSuccess
    }

    private func sendWithoutCofirmation(message: MSMessage) -> Bool {
        guard let conversation = activeConversation else { fatalError("Conversation Expected") }
        var isSuccess = true
        conversation.send(message) { error in
            if let error = error {
                log.error("Error in sending message \(error)")
                isSuccess = false
            }
        }
        return isSuccess
    }

    open func send(caption: String, summaryText: String, withConfirmation: Bool, injectCurrentPlayer: Bool = false) {
        let message = composeMessage(caption: caption, summaryText: summaryText)
        guard let game = sceneManager.current?.game else { return }

        let game2: Game
        if injectCurrentPlayer {
            game2 = setupYourselfPlayer(game: game)
        } else {
            game2 = game
        }
        guard let gameUrl = serializeGame(game: game2) else { return }
        message.url = gameUrl
        if send(message: message, withConfirmation: withConfirmation) {
            log.info("Successfully sent message.")
        }
    }
}
