//
//  TableViewCell.swift
//  IDExamples
//
//  Created by Igor Dorofix on 7/27/17.
//  Copyright © 2017 ID. All rights reserved.
//

import UIKit

let kArtistCellBackgroundColor = UIColor.cyan

class ArtistTableCell: UITableViewCell, ConfigurableCell {
    func configure(model: ArtistModel) {
        self.contentView.backgroundColor = kArtistCellBackgroundColor
        self.textLabel?.text = model.name
    }
}
