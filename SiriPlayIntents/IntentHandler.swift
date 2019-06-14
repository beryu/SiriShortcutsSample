//
//  IntentHandler.swift
//  SiriPlayIntents
//
//  Created by Ryuta Kibe on 2019/06/14.
//  Copyright © 2019 blk. All rights reserved.
//

import Intents

final class IntentHandler: INExtension, INPlayMediaIntentHandling {

    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }

    func resolveMediaItems(for intent: INPlayMediaIntent, with completion: @escaping ([INPlayMediaMediaItemResolutionResult]) -> Void) {
        completion([INPlayMediaMediaItemResolutionResult.unsupported()])
    }
    
    func handle(intent: INPlayMediaIntent, completion: @escaping (INPlayMediaIntentResponse) -> Void) {
        completion(INPlayMediaIntentResponse(code: .handleInApp, userActivity: nil))
    }

    private func resolveMediaItem(for intent: INAddMediaIntent, with completion: @escaping (INMediaItem?) -> Void) {
        
    }
}
