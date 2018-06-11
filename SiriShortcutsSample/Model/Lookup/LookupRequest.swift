//
//  LookupRequest.swift
//  SiriShortcutsSample
//
//  Created by Ryuta Kibe on 2018/01/05.
//  Copyright © 2018 blk. All rights reserved.
//

import APIKit

struct LookupRequest: Request {

    typealias Response = LookupResponse

    var method: HTTPMethod {
        return .get
    }
    var path: String {
        return "/lookup"
    }
    var queryParameters: [String : Any]? {
        return [
            "id": self.collectionId,
            "entity": "song",
            "country": "jp"
        ]
    }
    var baseURL: URL {
        return URL(string: "https://itunes.apple.com")!
    }
    var collectionId: Int

    init(collectionId: Int) {
        self.collectionId = collectionId
    }
}

extension LookupRequest {
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
