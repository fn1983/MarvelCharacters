//
//  ApiDataNetworkConfig.swift
//  MarvelCharacters
//
//  Created by PAUL SOTO on 30/6/21.
//

import Foundation

struct ApiDataNetworkConfig: NetworkConfigurable {
    let baseURL: URL
    let headers: [String: String]
    var queryParameters: [String: String]

    init(
        headers: [String: String] = [:],
        queryParameters: [String: String] = [:]
    ) {
        self.baseURL = URL(string: Constants.Api.baseUrl)!
        self.headers = headers
        self.queryParameters = queryParameters

        let ts = Date().currentTimeInMillis
        var params = [
            "apikey": Constants.Api.publicKey,
            "ts": "\(ts)",
            "hash": "\(ts)\(Constants.Api.privateKey)\(Constants.Api.publicKey)".md5
        ]
        params.merge(queryParameters) { (current, _) in current }
        self.queryParameters = params
    }
}
