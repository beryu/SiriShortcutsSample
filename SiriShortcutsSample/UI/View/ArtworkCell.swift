//
//  ArtworkCell.swift
//  SiriShortcutsSample
//
//  Created by beryu on 2018/01/07.
//  Copyright © 2018 blk. All rights reserved.
//

import UIKit

class ArtworkCell: UITableViewCell {

    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!

    func set(isHighlighted: Bool) {
        self.titleLabel.textColor = isHighlighted ? UIColor.red : UIColor.black
    }
}
