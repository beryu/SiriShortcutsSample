//
//  Structs.swift
//  SiriShortcutsSample
//
//  Created by beryu on 2018/06/12.
//  Copyright © 2018 blk. All rights reserved.
//

struct EntityTrack {
    let trackId: Int
    let collectionId: Int
    let trackName: String
    let artistName: String
    let collectionName: String
    let artworkUrl: String
    let previewUrl: String

    init(trackId: Int,
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

    init(from item: LookupResponseResult) {
        self.trackId = item.trackId ?? 0
        self.collectionId = item.collectionId
        self.trackName = item.trackName ?? ""
        self.artistName = item.artistName
        self.collectionName = item.collectionName
        self.artworkUrl = item.artworkUrl
        self.previewUrl = item.previewUrl ?? ""
    }
}

struct EntityAlbum {
    let collectionId: Int
    let collectionName: String
    let artistName: String
    let artworkUrl: String

    init(from responseAlbum: ResponseAlbum) {
        self.collectionId = responseAlbum.collectionId
        self.collectionName = responseAlbum.collectionName
        self.artistName = responseAlbum.artistName
        self.artworkUrl = responseAlbum.artworkUrl
    }
}

struct EntityAlbumDetail {

    var collectionId: Int = 0
    var artistName: String = ""
    var collectionName: String = ""
    var artworkUrl: String = ""
    var tracks: [EntityTrack] = []

    init() {}

    init(from lookupResponse: LookupResponse) {
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
