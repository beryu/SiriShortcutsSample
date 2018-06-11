//
//  SearchRequest.swift
//  SiriShortcutsSample
//
//  Created by Ryuta Kibe on 2017/11/17.
//  Copyright © 2017 AWA Co. Ltd. All rights reserved.
//

import APIKit

struct SearchRequest: Request {

    typealias Response = SearchResponse

    var method: HTTPMethod {
        return .get
    }
    var path: String {
        return "/search"
    }
    var queryParameters: [String : Any]? {
        return [
            "term": self.keyword,
            "media": "music",
            "entity": "album",
            "country": "jp"
        ]
    }
    var baseURL: URL {
        return URL(string: "https://itunes.apple.com")!
    }
    var keyword: String

    init(keyword: String) {
        self.keyword = keyword
    }
}

extension SearchRequest {
    var dataParser: DataParser {
        return DecodableDataParser()
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }
        return try JSONDecoder().decode(Response.self, from: data)
    }
}
