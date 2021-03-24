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
    internal func serializeGame(game: Game) -> URL? {
        /// Encode the game into the URL

        let json = encode(game: game)
        let gameUrlQueryItem = URLQueryItem(name: "game", value: json)
        let gameUUIDQueryItem = URLQueryItem(name: "uuid", value: UUID().uuidString)
        var components = URLComponents()
        var items = [URLQueryItem]()
        items.append(gameUrlQueryItem)
        items.append(gameUUIDQueryItem)
        components.queryItems = items
        return components.url
    }

    internal func deserializeGame(url: URL?) -> Game? {
        log.info("Deseriliazing Game")
        if let u = url {
            guard let urlComponents = NSURLComponents(url: u, resolvingAgainstBaseURL: false) else { return nil }
            guard let queryItems = urlComponents.queryItems else { return nil }

            // decode
            guard let gameJsonString = queryItems[0].value else { return nil }

            let game = decode(jsonString: gameJsonString, classType: gameType)

            return game
        }
        return nil
    }

    internal func getGameUUID(url: URL?) -> String? {
        if let u = url {
            guard let urlComponents = NSURLComponents(url: u, resolvingAgainstBaseURL: false) else { return nil }
            guard let queryItems = urlComponents.queryItems else { return nil }

            // decode
            guard let uuidString = queryItems[1].value else { return nil }

            return uuidString
        }
        return nil
    }

    /// Decode the JSON into a swift codable type
    /// - Parameters:
    ///   - jsonString: String fo Json
    ///   - type: Codable Type to cast
    /// - Returns: The type
    internal func decode<T: Game>(jsonString: String, classType: T.Type) -> T? {
        let jsonDecoder = JSONDecoder()
        do {
            let game = try jsonDecoder.decode(classType, from: jsonString.data(using: .utf8)!)
            return game
        } catch {
            print("failed")
            return nil
        }
    }

    /// Encode a Codable type to JSON
    /// - Parameter game: Codable
    /// - Returns: JSON String
    internal func encode(game: Game) -> String {
        // convert to json
        let jsonEncoder = JSONEncoder()

        // convert to json and then convert to string
        do {
            let jsonData = try jsonEncoder.encode(game)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            return jsonString

        } catch {
            return ""
        }
    }
}
