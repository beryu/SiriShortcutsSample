//
//  MusicPlayer.swift
//  SiriShortcutsSample
//
//  Created by beryu on 2018/06/13.
//  Copyright © 2018 blk. All rights reserved.
//

import AVFoundation

final class MusicPlayer {
    static let shared = MusicPlayer()
    let player = AVQueuePlayer()

    init() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default, options: [])
            try audioSession.setActive(true)
        } catch let error {
            print("[ERROR] \(error.localizedDescription)")
        }
    }

    func append(url: URL) {
        let item = AVPlayerItem(url: url)
        self.player.insert(item, after: self.player.items().last)
    }

    func play() {
        self.player.play()
    }

    func pause() {
        self.player.pause()
    }

    func skip() {
        self.player.advanceToNextItem()
    }
}
