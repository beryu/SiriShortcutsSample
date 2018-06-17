//
//  INPlayMediaIntentHandler.swift
//  MediaPlayIntents
//
//  Created by beryu on 2018/06/17.
//  Copyright © 2018 blk. All rights reserved.
//

import UIKit
import Intents
import CoreSpotlight
import MediaPlayer
import MusicPlayer

@available(iOS 12.0, *)
final class INPlayMediaIntentHandler: NSObject, INPlayMediaIntentHandling {
    func handle(intent: INPlayMediaIntent, completion: @escaping (INPlayMediaIntentResponse) -> Void) {
        guard
            let item = intent.mediaItems?.first,
            let trackName = item.title,
            let urlString = item.identifier,
            let url = URL(string: urlString) else {
                print("❌ NG")
                return
        }
        print("😉 OK: \(trackName)")
        
        // Donate as User Activity
        let userActivity = NSUserActivity(activityType: "jp.blk.SiriShortcutsSample.playback-activity-type")
        userActivity.isEligibleForSearch = true
        userActivity.title = "Play \(trackName)"
        userActivity.userInfo = ["previewUrl": url]
        userActivity.isEligibleForPrediction = true
        userActivity.suggestedInvocationPhrase = "Play \(trackName)"
        let attributes = CSSearchableItemAttributeSet(itemContentType: kCGImageAuxiliaryDataTypePortraitEffectsMatte as String)
        userActivity.contentAttributeSet = attributes
        userActivity.becomeCurrent()

        MusicPlayer.shared.set(trackName: trackName, url: url)
        MusicPlayer.shared.play()

        let response = INPlayMediaIntentResponse(code: INPlayMediaIntentResponseCode.success, userActivity: userActivity)
        response.nowPlayingInfo = [
            MPMediaItemPropertyTitle: trackName,
            MPMediaItemPropertyPlaybackDuration: 30,
            MPNowPlayingInfoPropertyElapsedPlaybackTime: 0,
            MPMediaItemPropertyAssetURL: url
        ]
        completion(response)
    }


}
