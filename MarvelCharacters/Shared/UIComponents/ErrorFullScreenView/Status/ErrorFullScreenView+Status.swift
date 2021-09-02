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
                return "Mmm. Parece que algo falta"
            }
        }

        var caption: String? {
            switch self {
            case .generalError:
                return "The superheros are lost in another galaxy. Come back later."
            case .networkError:
                return "Looks like we are experimenting some connectivity issues. Check your connection."
            case .missingCredentials:
                return "Asegurate de haber puesto las credenciales de acceso al API. Para más información, ver el README.md"
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
