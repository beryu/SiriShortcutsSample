//
//  MediaPlayIntentHandler.swift
//  MediaPlayIntents
//
//  Created by beryu on 2018/06/16.
//  Copyright © 2018 blk. All rights reserved.
//

import Foundation

final class MediaPlayIntentHandler: NSObject, MediaPlayIntentHandling {

    func handle(intent: MediaPlayIntent, completion: @escaping (MediaPlayIntentResponse) -> Void) {
        // MARK: - MediaPlayIntentHandling
        print("👍handle called with \(intent.trackName)")
        completion(MediaPlayIntentResponse(code: .success, userActivity: nil))
    }
}
