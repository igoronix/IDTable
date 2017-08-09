//
//  SectionBuilder.swift
//  IDDynamicCollectionView
//
//  Created by Igor Dorofix on 8/2/17.
//  Copyright © 2017 ID. All rights reserved.
//

import UIKit

protocol SectionBuilder: class {
    var reuseableHeaderId: String { get }
    var rowBuilders: [RowBuilder] { get }
    var title: String { get }
    var expandable: Bool { get }
    
    func configure(header: UITableViewHeaderFooterView)
    func headerHeight(for bounds: CGRect) -> CGFloat
    func appendRowBuilder(_ builder: RowBuilder)
}

class TableSectionBuilder<HeaderViewType: UITableViewHeaderFooterView>: SectionBuilder where HeaderViewType: ConfigurableHeader {
    
    var rowBuilders: [RowBuilder] = []
    var title: String
    
    var expandable: Bool {
        return HeaderViewType() is TouchableHeader
    }
    
    var reuseableHeaderId: String {
        return String(describing: HeaderViewType.identifier())
    }
    
    init(title: String) {
        self.title = title
    }
    
    convenience init(title: String, builders: [RowBuilder]) {
        self.init(title: title)
        self.rowBuilders.append(contentsOf: builders)
    }
    
    func appendRowBuilder(_ builder: RowBuilder) {
        self.rowBuilders.append(builder)
    }
    
    func configure(header: UITableViewHeaderFooterView) {
        (header as? HeaderViewType)?.configure(sectionBuilder: self)
    }
    
    func headerHeight(for bounds: CGRect) -> CGFloat {
        return HeaderViewType.height(model: self, for: bounds)
    }
}
