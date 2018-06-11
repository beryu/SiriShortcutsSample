//
//  SearchResponse.swift
//  SiriShortcutsSample
//
//  Created by Ryuta Kibe on 2017/11/17.
//  Copyright © 2018 blk. All rights reserved.
//

import Foundation

struct SearchResponse: Decodable {
    var results: [ResponseAlbum]
    var resultCount: Int
}

struct ResponseAlbum: Decodable {
    let collectionId: Int
    let collectionName: String
    let artistName: String
    let artworkUrl: String

    enum CodingKeys: String, CodingKey {
        case collectionId
        case collectionName
        case artistName
        case artworkUrl =  "artworkUrl100"
    }
}
