//
//  StubResponse+Extensions.swift
//  MarvelCharactersTests
//
//  Created by Paul Soto on 2/9/21.
//

import Hippolyte
import XCTest

extension StubResponse.Builder {
    func addBodyWithFileName(fileName: String) -> StubResponse.Builder {
        let fileDataResult = JSONReader(
            bundle: .testingBundle
        ).dataFromJson(withName: fileName)

        switch fileDataResult {
        case .success(let fileData):
            self.addBody(fileData)
            return self
        case .failure(let error):
            XCTFail(String(describing: error.localizedDescription))
            return self
        }
    }
}
