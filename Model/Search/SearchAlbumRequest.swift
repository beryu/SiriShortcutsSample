//
//  SearchAlbumRequest.swift
//  SiriShortcutsSample
//
//  Created by Ryuta Kibe on 2017/11/17.
//  Copyright © 2018 blk. All rights reserved.
//

import APIKit

public struct SearchAlbumRequest: Request {

    public typealias Response = SearchAlbumResponse

    public var method: HTTPMethod {
        return .get
    }
    public var path: String {
        return "/search"
    }
    public var queryParameters: [String : Any]? {
        return [
            "term": self.keyword,
            "media": "music",
            "entity": "album",
            "country": "jp"
        ]
    }
    public var baseURL: URL {
        return URL(string: "https://itunes.apple.com")!
    }
    public var keyword: String

    public init(keyword: String) {
        self.keyword = keyword
    }
}

extension SearchAlbumRequest {
    public var dataParser: DataParser {
        return DecodableDataParser()
    }

    public func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }
        return try JSONDecoder().decode(Response.self, from: data)
    }
}
