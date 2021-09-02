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

        var title: String? {
            switch self {
            case .generalError:
                return "Ups! something weird is happening!"
            case .networkError:
                return "Houston, we have a problem."
            }
        }

        var caption: String? {
            switch self {
            case .generalError:
                return "The superheros are lost in another galaxy. Come back later."
            case .networkError:
                return "Looks like we are experimenting some connectivity issues. Check your connection."
            }
        }

        var image: String? {
            switch self {
            case .generalError:
                return "galaxy"
            case .networkError:
                return "satellite"
            }
        }
    }
}
