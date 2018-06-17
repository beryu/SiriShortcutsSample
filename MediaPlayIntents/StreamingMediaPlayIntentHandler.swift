//
//  StreamingMediaPlayIntentHandler.swift
//  MediaPlayIntents
//
//  Created by beryu on 2018/06/16.
//  Copyright © 2018 blk. All rights reserved.
//

import Foundation
import MusicPlayer

@available(iOS 12.0, *)
final class StreamingMediaPlayIntentHandler: NSObject, StreamingMediaPlayIntentHandling {

    func handle(intent: StreamingMediaPlayIntent, completion: @escaping (StreamingMediaPlayIntentResponse) -> Void) {
        guard
            let trackName = intent.trackName,
            let previewUrl = intent.previewUrl else {
                return
        }
        MusicPlayer.shared.set(trackName: trackName, url: previewUrl)
        MusicPlayer.shared.play()
        let response = StreamingMediaPlayIntentResponse.success(trackName: trackName)
        completion(response)
    }

}
