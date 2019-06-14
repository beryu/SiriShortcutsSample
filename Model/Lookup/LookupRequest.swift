//
//  LookupRequest.swift
//  SiriShortcutsSample
//
//  Created by Ryuta Kibe on 2018/01/05.
//  Copyright © 2018 blk. All rights reserved.
//

import APIKit

public struct LookupRequest: Request {

    public typealias Response = LookupResponse

    public var method: HTTPMethod {
        return .get
    }
    public var path: String {
        return "/lookup"
    }
    public var queryParameters: [String : Any]? {
        return [
            "id": self.collectionId,
            "entity": "song",
            "country": "jp"
        ]
    }
    public var baseURL: URL {
        return URL(string: "https://itunes.apple.com")!
    }
    var collectionId: Int

    public init(collectionId: Int) {
        self.collectionId = collectionId
    }
}

extension LookupRequest {
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
