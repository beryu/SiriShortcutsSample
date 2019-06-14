//
//  SearchAlbumResponse.swift
//  SiriShortcutsSample
//
//  Created by Ryuta Kibe on 2017/11/17.
//  Copyright © 2018 blk. All rights reserved.
//

import Foundation

public struct SearchAlbumResponse: Decodable {
    public var results: [ResponseAlbum]
    public var resultCount: Int
}

public struct ResponseAlbum: Decodable {
    public let collectionId: Int
    public let collectionName: String
    public let artistName: String
    public let artworkUrl: String

    enum CodingKeys: String, CodingKey {
        case collectionId
        case collectionName
        case artistName
        case artworkUrl =  "artworkUrl100"
    }
}
