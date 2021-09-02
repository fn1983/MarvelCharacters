//
//  ErrorFullScreenView+Status.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 1/9/21.
//

import Foundation

extension ErrorFullScreenView {
    enum Status: CaseIterable {
        case generalError
        case networkError
        case missingCredentials

        var title: String? {
            switch self {
            case .generalError:
                return "Ups! something weird is happening!"
            case .networkError:
                return "Houston, we have a problem."
            case .missingCredentials:
                return "Mmm. Looks like something is missing"
            }
        }

        var caption: String? {
            switch self {
            case .generalError:
                return "The superheros are lost in another galaxy. Come back later."
            case .networkError:
                return "Looks like we are experimenting some connectivity issues. Check your connection."
            case .missingCredentials:
                return "Make sure you have configured the credentials to access the API. For more information, see the README.md"
            }
        }

        var image: String? {
            switch self {
            case .generalError, .missingCredentials:
                return "galaxy"
            case .networkError:
                return "satellite"
            }
        }
    }
}
