//
//  AlbumHeader.swift
//  IDTableView
//
//  Created by Igor Dorofix on 8/8/17.
//  Copyright © 2017 ID. All rights reserved.
//

import UIKit

let kAlbumHeaderHighlightedColor = UIColor.lightGray
let kAlbumHeaderColor = UIColor.lightText
let kAlbumHeaderInsets = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)

class AlbumHeader: UITableViewHeaderFooterView, TouchableHeader {

    @IBOutlet fileprivate var titleLabel: UILabel!
    weak var delegate: HeaderViewDelegate?

    var isHighlighted: Bool = false {
        didSet {
            self.contentView.backgroundColor = self.isHighlighted ? kAlbumHeaderHighlightedColor : kAlbumHeaderColor
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectHeader(_:)))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBAction func selectHeader(_ sender: Any) {
        self.delegate?.didSelectHeader(self)
    }
}

extension AlbumHeader: ConfigurableHeader {
    func configure(sectionBuilder: SectionBuilder) {
        self.titleLabel?.text = sectionBuilder.title
    }
    
    static func height(model: SectionBuilder, for bounds: CGRect) -> CGFloat {
        return model.title.heightWithConstrainedWidth(width: bounds.width - kAlbumHeaderInsets.left - kAlbumHeaderInsets.right, font: UIFont.systemFont(ofSize: 17)) + kAlbumHeaderInsets.bottom + kAlbumHeaderInsets.top
    }
}
