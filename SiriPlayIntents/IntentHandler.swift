//
//  IntentHandler.swift
//  SiriPlayIntents
//
//  Created by Ryuta Kibe on 2019/06/14.
//  Copyright © 2019 blk. All rights reserved.
//

import Intents
import APIKit
import Model

final class IntentHandler: INExtension {
    func resolveMediaItem(for optionalMediaSearch: INMediaSearch?, completion: @escaping (INMediaItem?) -> Void) {
        guard let keyword = optionalMediaSearch?.mediaName else {
            completion(nil)
            return
        }
        let request = SearchTrackRequest(keyword: keyword)
        Session.send(request) { result in
            switch result {
            case .success(let response):
                guard let responseTrack = response.results.first else {
                    completion(nil)
                    return
                }
                let image: INImage?
                if let url = URL(string: responseTrack.previewUrl ?? "") {
                    image = INImage(url: url)
                } else {
                    image = nil
                }
                let item = INMediaItem(
                    identifier: "\(responseTrack.previewUrl ?? "")",
                    title: responseTrack.trackName ?? "",
                    type: .song,
                    artwork: image)
                completion(item)
            case .failure(let error):
                switch error {
                case .connectionError(let connectionError):
                    NSLog(connectionError.localizedDescription)
                case .requestError(let requestError):
                    NSLog(requestError.localizedDescription)
                case .responseError(let responseError):
                    NSLog(responseError.localizedDescription)
                }
            }
        }
    }
}

extension IntentHandler: INPlayMediaIntentHandling {
    func resolveMediaItems(for intent: INPlayMediaIntent, with completion: @escaping ([INPlayMediaMediaItemResolutionResult]) -> Void) {
        resolveMediaItem(for: intent.mediaSearch) { optionalMediaItem in
            guard let mediaItem = optionalMediaItem else {
                completion([INPlayMediaMediaItemResolutionResult.unsupported()])
                return
            }
            completion([INPlayMediaMediaItemResolutionResult.success(with: mediaItem)])
        }
    }

    func handle(intent: INPlayMediaIntent, completion: @escaping (INPlayMediaIntentResponse) -> Void) {
        completion(INPlayMediaIntentResponse(code: .handleInApp, userActivity: nil))
    }

}
