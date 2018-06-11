//
//  ViewController.swift
//  SiriShortcutsSample
//
//  Created by beryu on 2018/06/11.
//  Copyright © 2018 blk. All rights reserved.
//

import UIKit
import CoreSpotlight
import Intents

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Define activities
        let userActivity = NSUserActivity(activityType: "jp.blk.SiriShortcutsSample.playback-activity-type")
        userActivity.isEligibleForSearch = true
        userActivity.title = "Playback"
        userActivity.userInfo = ["key": "value"]
        self.userActivity = userActivity

        if #available(iOS 12.0, *) {
            userActivity.isEligibleForPrediction = true
            userActivity.suggestedInvocationPhrase = "Let's do it"
            let attributes = CSSearchableItemAttributeSet(itemContentType: kCGImageAuxiliaryDataTypePortraitEffectsMatte as String)
            attributes.contentDescription = "It's OK if you see this!"
            userActivity.contentAttributeSet = attributes
        }

        userActivity.becomeCurrent()
    }


}

