//
//  MarvelCharactersError.swift
//  MarvelCharacters
//
//  Created by PAUL SOTO on 31/8/21.
//

import Foundation

public struct MarvelCharactersError {
    public enum Database: Error, Equatable {
        case notAvailable
        case noResults
        case dataError
        case entryNotExist(entity: String, id: String?)
        case writeError
    }

    public enum General: Error {
        case expired
        case unexpected
        case badCodingKey
        case badPayload
        case invalidEditorialContent
        case badDate
        case badUrl
        case badTimeZone
        case badTypeCast
        case mapping(entity: String)
    }

    public enum NetworkError: Error {
        case error(statusCode: Int, data: Data?)
        case notConnected
        case cancelled
        case generic(Error)
        case urlGeneration

        public static func == (lhs: MarvelCharactersError.NetworkError, rhs: MarvelCharactersError.NetworkError) -> Bool {
            switch (lhs, rhs) {
            case (.error(statusCode: let statusLhs, data: _), .error(statusCode: let statusRhs, data: _)):
                return statusLhs == statusRhs
            case (.notConnected, .notConnected):
                return true
            case (.cancelled, .cancelled):
                return true
            case (.urlGeneration, .urlGeneration):
                return true
            default:
                return false
            }
        }
    }

    public enum DataTransferError: Error {
        case noResponse
        case parsing(Error)
        case networkFailure(NetworkError)
        case resolvedNetworkFailure(Error)
    }
}
