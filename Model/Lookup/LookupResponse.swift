//
//  LookupResponse.swift
//  SiriShortcutsSample
//
//  Created by Ryuta Kibe on 2018/01/05.
//  Copyright © 2018 blk. All rights reserved.
//

import Foundation

public struct LookupResponse: Decodable {
    var results: [LookupResponseResult]
}

public struct LookupResponseResult: Decodable {
    public let trackId: Int?
    public let collectionId: Int
    public let type: String
    public let trackName: String?
    public let artistName: String
    public let collectionName: String
    public let artworkUrl: String
    public let previewUrl: String?

    enum CodingKeys: String, CodingKey {
        case trackId
        case collectionId
        case type = "wrapperType"
        case trackName
        case artistName
        case collectionName
        case artworkUrl = "artworkUrl100"
        case previewUrl
    }
}
