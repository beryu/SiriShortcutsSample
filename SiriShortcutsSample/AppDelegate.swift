//
//  AppDelegate.swift
//  SiriShortcutsSample
//
//  Created by beryu on 2018/06/11.
//  Copyright © 2018 blk. All rights reserved.
//

import UIKit
import Intents
import MusicPlayer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        INPreferences.requestSiriAuthorization { status in
            switch status {
            case .notDetermined, .restricted, .denied:
                print("I can't use SiriKit")
            case .authorized:
                print("SiriKit is available")
            @unknown default:
                fatalError()
            }
        }

        return true
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if userActivity.activityType == "jp.blk.SiriShortcutsSample.playback-activity-type",
           let trackName = userActivity.userInfo?["trackName"] as? String,
           let url = userActivity.userInfo?["previewUrl"] as? URL {
            MusicPlayer.shared.set(trackName: trackName, url: url)
            MusicPlayer.shared.play()

            return true
        }

        return false
    }

    func application(_ application: UIApplication, handle intent: INIntent, completionHandler: @escaping (INIntentResponse) -> Void) {
        guard #available(iOS 12.0, *) else {
            return
        }
        guard
            let playMediaIntent = intent as? INPlayMediaIntent,
            let mediaItem = playMediaIntent.mediaItems?.first,
            let urlString = mediaItem.identifier,
            let url = URL(string: urlString),
            let trackName = mediaItem.title else {
                completionHandler(INPlayMediaIntentResponse(code: .failure, userActivity: nil))
                return
        }
        MusicPlayer.shared.set(trackName: trackName, url: url)
        MusicPlayer.shared.play()
    }

}

