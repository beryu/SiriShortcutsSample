//
//  Structs.swift
//  SiriShortcutsSample
//
//  Created by beryu on 2018/06/12.
//  Copyright © 2018 blk. All rights reserved.
//

public struct EntityTrack {
    public let trackId: Int
    public let collectionId: Int
    public let trackName: String
    public let artistName: String
    public let collectionName: String
    public let artworkUrl: String
    public let previewUrl: String

    public init(trackId: Int,
                collectionId: Int,
                trackName: String,
                artistName: String,
                collectionName: String,
                artworkUrl: String,
                previewUrl: String) {
        self.trackId = trackId
        self.collectionId = collectionId
        self.trackName = trackName
        self.artistName = artistName
        self.collectionName = collectionName
        self.artworkUrl = artworkUrl
        self.previewUrl = previewUrl
    }

    public init(from item: LookupResponseResult) {
        self.trackId = item.trackId ?? 0
        self.collectionId = item.collectionId
        self.trackName = item.trackName ?? ""
        self.artistName = item.artistName
        self.collectionName = item.collectionName
        self.artworkUrl = item.artworkUrl
        self.previewUrl = item.previewUrl ?? ""
    }
}

public struct EntityAlbum {
    public let collectionId: Int
    public let collectionName: String
    public let artistName: String
    public let artworkUrl: String

    public init(from responseAlbum: ResponseAlbum) {
        self.collectionId = responseAlbum.collectionId
        self.collectionName = responseAlbum.collectionName
        self.artistName = responseAlbum.artistName
        self.artworkUrl = responseAlbum.artworkUrl
    }
}

public struct EntityAlbumDetail {

    public var collectionId: Int = 0
    public var artistName: String = ""
    public var collectionName: String = ""
    public var artworkUrl: String = ""
    public var tracks: [EntityTrack] = []

    public init() {}

    public init(from lookupResponse: LookupResponse) {
        for result in lookupResponse.results {
            switch result.type {
            case "collection":
                self.collectionId = result.collectionId
                self.collectionName = result.collectionName
                self.artistName = result.artistName
                self.artworkUrl = result.artworkUrl
            case "track":
                let track = EntityTrack(from: result)
                self.tracks.append(track)
            default:
                break
            }
        }
    }

}
