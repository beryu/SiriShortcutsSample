//
//  ControlViewController.swift
//  SiriShortcutsSample
//
//  Created by beryu on 2018/06/13.
//  Copyright © 2018 blk. All rights reserved.
//

import UIKit
import Intents
import IntentsUI
import RxSwift
import RxCocoa
import MusicPlayer

final class ControlViewController: UIViewController {

    // MARK: - IBOutlet

    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var pauseButton: UIButton!
    @IBOutlet private weak var registerUserActivityButton: UIButton!
    @IBOutlet private weak var registerIntentButton: UIButton!

    // MARK: - Private properties

    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.playButton.rx.tap.asSignal()
            .emit(onNext: { _ in
                MusicPlayer.shared.play()
            })
            .disposed(by: self.bag)

        self.pauseButton.rx.tap.asSignal()
            .emit(onNext: { _ in
                MusicPlayer.shared.pause()
            })
            .disposed(by: self.bag)

        self.registerUserActivityButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] _ in
                self?.registerUserActivityShortcuts()
            })
            .disposed(by: self.bag)

        self.registerIntentButton.rx.tap.asSignal()
            .emit(onNext: { [weak self] _ in
                self?.registerIntentShortcuts()
            })
            .disposed(by: self.bag)
    }

    private func registerUserActivityShortcuts() {
        if #available(iOS 12.0, *) {
            let player = MusicPlayer.shared
            guard
                let trackName = player.trackName,
                let previewUrl = player.url else {
                    return
            }

            let userActivity = NSUserActivity(activityType: "jp.blk.SiriShortcutsSample.playback-activity-type")
            userActivity.isEligibleForSearch = true
            userActivity.title = "\(trackName)を再生する"
            userActivity.addUserInfoEntries(from: [
                "trackName": trackName,
                "previewUrl": previewUrl
                ])
            userActivity.isEligibleForPrediction = true
            userActivity.suggestedInvocationPhrase = "\(trackName)を再生して"
            let shortcut = INShortcut(userActivity: userActivity)

            let vc = INUIAddVoiceShortcutViewController(shortcut: shortcut)
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        }
    }

    private func registerIntentShortcuts() {
        if #available(iOS 12.0, *) {
            let player = MusicPlayer.shared
            guard
                let trackName = player.trackName,
                let previewUrl = player.url else {
                    return
            }

            let item = INMediaItem(identifier: previewUrl.absoluteString,
                                   title: trackName,
                                   type: .song,
                                   artwork: nil)
            let intent = INPlayMediaIntent(mediaItems: [item],
                                           mediaContainer: nil,
                                           playShuffled: false,
                                           playbackRepeatMode: .none,
                                           resumePlayback: true)
            intent.suggestedInvocationPhrase = "\(trackName)を再生して"
            guard let shortcut = INShortcut(intent: intent) else {
                return
            }

            let vc = INUIAddVoiceShortcutViewController(shortcut: shortcut)
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        }
    }
}

extension ControlViewController: INUIAddVoiceShortcutViewControllerDelegate {
    @available(iOS 12.0, *)
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

    @available(iOS 12.0, *)
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }


}
