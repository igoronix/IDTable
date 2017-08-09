//
//  ArtistTableViewCell.swift
//  IDExamples
//
//  Created by Igor Dorofix on 7/27/17.
//  Copyright © 2017 ID. All rights reserved.
//

import UIKit

let kAlbumCellBackgroundColor = UIColor.green

class AlbumTableCell: UITableViewCell, ConfigurableCell {
    func configure(model: AlbumModel) {
        self.contentView.backgroundColor = kAlbumCellBackgroundColor
        self.textLabel?.text = model.name
    }
}

