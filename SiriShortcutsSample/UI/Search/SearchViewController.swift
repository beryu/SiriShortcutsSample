//
//  SearchViewController.swift
//  SiriShortcutsSample
//
//  Created by beryu on 2018/06/11.
//  Copyright © 2018 blk. All rights reserved.
//

import UIKit
import Intents
import RxSwift
import RxCocoa
import Nuke
import APIKit
import Model

final class SearchViewController: UIViewController {

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

    private let searchBar: UISearchBar = UISearchBar(frame: .zero)
    private var albums: [EntityAlbum] = []
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let searchBarContainerView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: self.view.bounds.width, height: 44)))
        self.searchBar.frame = searchBarContainerView.bounds
        searchBarContainerView.addSubview(self.searchBar)
        self.navigationItem.titleView = searchBarContainerView
        self.searchBar.placeholder = "Album name, Artist name, Track name..."

        self.searchBar.rx.value.asDriver()
            .drive(onNext: { [weak self] (keyword) in
                guard let keyword = keyword else {
                    return
                }
                let request = SearchAlbumRequest(keyword: keyword)
                Session.send(request) { result in
                    switch result {
                    case .success(let response):
                        var items: [EntityAlbum] = []
                        for responseAlbum in response.results {
                            items.append(EntityAlbum(from: responseAlbum))
                        }
                        self?.albums = items
                        self?.tableView.reloadData()
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
            })
            .disposed(by: self.bag)
    }


}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albums.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ArtworkCell else {
            fatalError()
        }
        let item = self.albums[indexPath.row]
        cell.artworkImageView.image = nil
        if let url = URL(string: item.artworkUrl) {
            Nuke.loadImage(with: url, into: cell.artworkImageView)
        }
        cell.titleLabel.text = "\(item.collectionName)"
        cell.artistLabel.text = "\(item.artistName)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = self.albums[indexPath.row]
        let storyboard = UIStoryboard(name: "LookupViewController", bundle: nil)
        guard let lookupVC = storyboard.instantiateViewController(withIdentifier: "LookupViewController") as? LookupViewController else {
            // Maybe bug
            fatalError()
        }
        lookupVC.collectionId = item.collectionId
        self.navigationController?.pushViewController(lookupVC, animated: true)
    }
}
