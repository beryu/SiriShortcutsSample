//
//  MusicPlayer.swift
//  SiriShortcutsSample
//
//  Created by beryu on 2018/06/13.
//  Copyright © 2018 blk. All rights reserved.
//

import AVFoundation

public final class MusicPlayer {
    static public let shared = MusicPlayer()
    let player = AVQueuePlayer()

    public init() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default, options: [])
            try audioSession.setActive(true)
        } catch let error {
            print("[ERROR] \(error.localizedDescription)")
        }
    }

    public func set(url: URL) {
        let item = AVPlayerItem(url: url)
        self.player.removeAllItems()
        self.player.insert(item, after: nil)
    }

    public func append(url: URL) {
        let item = AVPlayerItem(url: url)
        self.player.insert(item, after: self.player.items().last)
    }

    public func play() {
        self.player.play()
    }

    public func pause() {
        self.player.pause()
    }

    public func skip() {
        self.player.advanceToNextItem()
    }
}
