//
//  IntentHandler.swift
//  MediaPlayIntents
//
//  Created by beryu on 2018/06/13.
//  Copyright © 2018 blk. All rights reserved.
//

import Intents

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

final class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any {
        if #available(iOS 12.0, *) {
            return MediaPlayIntentHandler()
        } else {
            return self
        }
    }
}
