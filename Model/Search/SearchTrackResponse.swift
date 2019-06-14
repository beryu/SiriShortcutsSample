//
//  SearchTrackResponse.swift
//  SiriShortcutsSample
//
//  Created by Ryuta Kibe on 2019/6/14.
//  Copyright © 2019 blk. All rights reserved.
//

import Foundation

public struct SearchTrackResponse: Decodable {
    public var results: [ResponseTrack]
    public var resultCount: Int
}

public struct ResponseTrack: Decodable {
    public let trackId: Int?
    public let collectionId: Int
    public let trackName: String?
    public let artistName: String
    public let collectionName: String
    public let artworkUrl: String
    public let previewUrl: String?

    enum CodingKeys: String, CodingKey {
        case trackId
        case collectionId
        case trackName
        case artistName
        case collectionName
        case artworkUrl = "artworkUrl100"
        case previewUrl
    }
}
