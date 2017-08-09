//
//  TableRowBuider.swift
//  IDExamples
//
//  Created by Igor Dorofix on 7/28/17.
//  Copyright © 2017 ID. All rights reserved.
//

import UIKit

protocol RowBuilder {
    var reuseableId: String { get }
    var itemsCount: Int { get }
    func configure(cell: UITableViewCell, itemIndex: Int)
}

class TableRowBuider<ItemType, CellType: UITableViewCell>: RowBuilder where CellType: ConfigurableCell, CellType.Model == ItemType {
    
    var reuseableId: String {
        return String(describing: CellType.identifier())
    }
    
    var itemsCount: Int {
        return self.items.count
    }
    
    var items = [ItemType]()
    
    init(items:[ItemType]) {
        self.items = items
    }
    
    func configure(cell: UITableViewCell, itemIndex: Int) {
        (cell as? CellType)?.configure(model: items[itemIndex])
    }
}
