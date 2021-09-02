//
//  JSONReader.swift
//  MarvelCharactersTests
//
//  Created by Paul Soto on 2/9/21.
//

@testable import MarvelCharacters
import Foundation

enum JSONReaderError: Error, LocalizedError {
    case fileNotFound
    case invalidURL
    case emptyURL
    case unexpected

    public var errorDescription: String? {
        switch self {
        case .emptyURL:
            return "Empty URL"
        case .invalidURL:
            return "Invalid URL"
        case .fileNotFound:
            return "File Not Found"
        case .unexpected:
            return "Unexpected Error"
        }
    }
}

class JSONReader {
    private let bundle: Bundle

    init(bundle: Bundle? = nil) {
        guard let bundle = bundle else {
            self.bundle = Bundle(for: type(of: self))
            return
        }
        self.bundle = bundle
    }

    func dataFromJson(withName name: String) -> Result<Data, Error> {
        do {
            guard !name.isEmpty else {
                throw JSONReaderError.emptyURL
            }

            guard let path = self.bundle.path(forResource: name, ofType: "json") else {
                throw JSONReaderError.invalidURL
            }
            guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                throw JSONReaderError.fileNotFound
            }
            return .success(data)
        } catch {
            return .failure(error)
        }
    }

    func objFromJson<T: Decodable>(withName name: String) -> Result<T, Error> {
        do {
            let data = try self.dataFromJson(withName: name).get()
            let result: T = try JSONResponseDecoder().decode(data)
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
}
