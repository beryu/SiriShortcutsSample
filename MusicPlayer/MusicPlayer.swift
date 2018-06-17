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
    public var trackName: String?
    public var url: URL?
    private let player = AVPlayer()

    public init() {
        player.allowsExternalPlayback = true
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default, policy: .longForm, options: [])
            try audioSession.setActive(true)
        } catch let error {
            print("[ERROR] \(error.localizedDescription)")
        }
    }

    public func set(trackName: String, url: URL) {
        self.trackName = trackName
        self.url = url
        let item = AVPlayerItem(url: url)
        self.player.replaceCurrentItem(with: item)
    }

    public func play() {
        self.player.play()
    }

    public func pause() {
        self.player.pause()
    }
}
