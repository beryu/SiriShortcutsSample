//
//  MediaPlayIntentHandler.swift
//  MediaPlayIntents
//
//  Created by beryu on 2018/06/16.
//  Copyright © 2018 blk. All rights reserved.
//

import Foundation
import MusicPlayer

@available(iOS 12.0, *)
final class MediaPlayIntentHandler: NSObject, MediaPlayIntentHandling {

    func handle(intent: MediaPlayIntent, completion: @escaping (MediaPlayIntentResponse) -> Void) {
        // MARK: - MediaPlayIntentHandling
        guard
            let trackName = intent.trackName,
            let previewUrl = intent.previewUrl else {
                return
        }
        MusicPlayer.shared.set(url: previewUrl)
        MusicPlayer.shared.play()
        let response = MediaPlayIntentResponse.success(trackName: trackName)
        completion(response)
    }

}
