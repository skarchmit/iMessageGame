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
        let session = _session ?? MSSession()

        let layout = MSMessageTemplateLayout()
        layout.caption = caption

        let message = MSMessage(session: session)

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
                print("Error in sending message")
                print(error)
            }
        }
    }

    private func sendWithoutCofirmation(message: MSMessage) {
        guard let conversation = activeConversation else { fatalError("Conversation Expected") }
        conversation.send(message) { error in
            if let error = error {
                print("Error in sending message")
                print(error)
            }
        }
    }

    open func send(caption: String, summaryText: String, withConfirmation: Bool) {
        let message = composeMessage(caption: caption, summaryText: summaryText)

        /// Attempt to send message
        if let game = sceneManager.current?.game, let gameUrl = serializeGame(game: game) {
            message.url = gameUrl
        }

        send(message: message, withConfirmation: withConfirmation)
    }
}
