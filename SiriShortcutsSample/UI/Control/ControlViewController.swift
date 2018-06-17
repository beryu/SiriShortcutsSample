//
//  ControlViewController.swift
//  SiriShortcutsSample
//
//  Created by beryu on 2018/06/13.
//  Copyright © 2018 blk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MusicPlayer

final class ControlViewController: UIViewController {

    // MARK: - IBOutlet

    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var pauseButton: UIButton!
    @IBOutlet private weak var skipButton: UIButton!

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

        self.skipButton.rx.tap.asSignal()
            .emit(onNext: { _ in
                MusicPlayer.shared.skip()
            })
            .disposed(by: self.bag)
    }
}
