//
//  LookupViewController.swift
//  LiverpoolV2Mock
//
//  Created by beryu on 2018/01/06.
//  Copyright © 2018 AWA Co. Ltd. All rights reserved.
//

import UIKit
import CoreSpotlight
import Intents
import RxSwift
import RxCocoa
import APIKit
import Nuke
import MusicPlayer

final class LookupViewController: UIViewController {

    // MARK: - Internal properties

    var collectionId: Int!

    // MARK: - IBOutlet

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            let cellName = String(describing: ArtworkCell.self)
            self.tableView.register(UINib(nibName: cellName, bundle: Bundle(for: ArtworkCell.self)), forCellReuseIdentifier: "Cell")
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
    }

    // MARK: - Private properties

    private var albumDetail: EntityAlbumDetail?
    private let bag = DisposeBag()

    // MARK: - Override methods

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.rx.itemSelected.asSignal()
            .emit(onNext: { [weak self] (indexPath) in
                guard
                    let item = self?.albumDetail?.tracks[indexPath.row],
                    let url = URL(string: item.previewUrl) else {
                        return
                }
                MusicPlayer.shared.append(url: url)
                MusicPlayer.shared.play()

                // Define activities
//                // Donate as User Activity
//                let userActivity = NSUserActivity(activityType: "jp.blk.SiriShortcutsSample.playback-activity-type")
//                userActivity.isEligibleForSearch = true
//                userActivity.title = "\(item.trackName)を再生"
//                userActivity.addUserInfoEntries(from: ["previewUrl": url])
//                userActivity.requiredUserInfoKeys = ["previewUrl"]
//                self?.userActivity = userActivity
//
//                if #available(iOS 12.0, *) {
//                    userActivity.isEligibleForPrediction = true
//                    userActivity.suggestedInvocationPhrase = "\(item.trackName)を再生"
//                    let attributes = CSSearchableItemAttributeSet(itemContentType: kCGImageAuxiliaryDataTypePortraitEffectsMatte as String)
//                    attributes.contentDescription = "\(item.artistName) - \(item.collectionName)"
//                    userActivity.contentAttributeSet = attributes
//                }
//
//                userActivity.becomeCurrent()

                // Donate as Interaction
                if #available(iOS 12.0, *) {
                    let intent = MediaPlayIntent()
                    intent.trackName = item.trackName
                    intent.previewUrl = url
                    let interaction = INInteraction(intent: intent, response: nil)
                    interaction.donate(completion: { error in
                        if let error = error {
                            print("[ERROR] \(error.localizedDescription)")
                        }
                    })
                }
            })
            .disposed(by: self.bag)

        // Load
        let request = LookupRequest(collectionId: collectionId)
        Session.send(request) { [weak self] result in
            switch result {
            case .success(let response):
                let albumDetail = EntityAlbumDetail(from: response)
                self?.albumDetail = albumDetail
                self?.tableView.reloadData()
                self?.navigationItem.title = albumDetail.collectionName
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

extension LookupViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

extension LookupViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albumDetail?.tracks.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ArtworkCell,
            let item = self.albumDetail?.tracks[indexPath.row] else {
                fatalError()
        }
        cell.artworkImageView.image = nil
        if let url = URL(string: item.artworkUrl) {
            Nuke.loadImage(with: url, into: cell.artworkImageView)
        }
        cell.titleLabel.text = "\(item.trackName)"
        cell.artistLabel.text = "\(item.artistName)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
