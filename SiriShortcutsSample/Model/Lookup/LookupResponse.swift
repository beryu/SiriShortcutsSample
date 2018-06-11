//
//  LookupResponse.swift
//  SiriShortcutsSample
//
//  Created by Ryuta Kibe on 2018/01/05.
//  Copyright © 2018 blk. All rights reserved.
//

import Foundation

struct LookupResponse: Decodable {
    var results: [LookupResponseResult]
}

struct LookupResponseResult: Decodable {
    let trackId: Int?
    let collectionId: Int
    let type: String
    let trackName: String?
    let artistName: String
    let collectionName: String
    let artworkUrl: String
    let previewUrl: String?

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
