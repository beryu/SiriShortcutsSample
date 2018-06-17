//
//  MediaPlayIntentHandler.swift
//  MediaPlayIntents
//
//  Created by beryu on 2018/06/16.
//  Copyright © 2018 blk. All rights reserved.
//

import Foundation
import MusicPlayer

final class MediaPlayIntentHandler: NSObject, MediaPlayIntentHandling {

    func handle(intent: MediaPlayIntent, completion: @escaping (MediaPlayIntentResponse) -> Void) {
        // MARK: - MediaPlayIntentHandling
        guard let previewUrl = intent.previewUrl else {
            return
        }
        print("👍handle called with \(intent.trackName)")
        MusicPlayer.shared.append(url: previewUrl)
        MusicPlayer.shared.play()
        completion(MediaPlayIntentResponse(code: .success, userActivity: nil))
    }
}
