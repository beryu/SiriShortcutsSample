//
//  MusicPlayer.swift
//  SiriShortcutsSample
//
//  Created by beryu on 2018/06/13.
//  Copyright © 2018 blk. All rights reserved.
//

import AVFoundation
import MediaPlayer

public final class MusicPlayer {
    static public let shared = MusicPlayer()
    public var trackName: String?
    public var url: URL?
    private let player = AVPlayer()

    public init() {
        self.player.allowsExternalPlayback = true
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.addTarget { [weak self] (_) -> MPRemoteCommandHandlerStatus in
            self?.play()
            return .success
        }
        commandCenter.playCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget { [weak self] (_) -> MPRemoteCommandHandlerStatus in
            self?.pause()
            return .success
        }
        commandCenter.pauseCommand.isEnabled = true
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
        let asset = AVAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        self.player.replaceCurrentItem(with: item)
        let nowPlaying = MPNowPlayingInfoCenter.default()
        nowPlaying.nowPlayingInfo = [
            MPMediaItemPropertyTitle: trackName,
            MPMediaItemPropertyPlaybackDuration: 30,
            MPNowPlayingInfoPropertyElapsedPlaybackTime: 0,
            MPMediaItemPropertyAssetURL: url
        ]

    }

    public func play() {
        self.player.play()
    }

    public func pause() {
        self.player.pause()
    }
}
