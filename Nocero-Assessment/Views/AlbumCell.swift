//
//  AlbumCell.swift
//  Nocero-Assessment
//
//  Created by Nocero Beguhe on 07/14/21.
//  Copyright © 2021 Nocero Beguhe. All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell {

    static let reuseIdentifier = "AlbumCell"
    
    @IBOutlet weak var artworkView: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with viewModel: AlbumCellViewModel) {
        artworkView.image = viewModel.artwork
        albumTitleLabel.text = viewModel.title
        genreLabel.text = viewModel.genre
        releaseDataLabel.text = viewModel.releaseDate
    }

}
