//
//  AlbumDetailController.swift
//  Nocero-Assessment
//
//  Created by Nocero Beguhe on 07/14/21.
//  Copyright © 2021 Nocero Beguhe. All rights reserved.
//

import UIKit

class AlbumDetailController: UITableViewController {

    var album: Album? {
        didSet {
            if let album = album {
                configure(with: album)
                dataSource.update(with: album.songs)
                tableView.reloadData()
            }
        }
    }

    var dataSource = AlbumDetailDataSource(songs: [])

    @IBOutlet weak var artworkView: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var albumGenreLabel: UILabel!
    @IBOutlet weak var albumReleaseDateLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let album = album {
            configure(with: album)
        }

        tableView.dataSource = dataSource
    }

    func configure(with album: Album) {
        let viewModel = AlbumDetailViewModel(album: album)

        // Add implmentation for artworkView

        albumTitleLabel.text = viewModel.title
        albumGenreLabel.text = viewModel.genre
        albumReleaseDateLabel.text = viewModel.releaseDate
    }
}
