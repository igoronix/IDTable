//
//  UITableViewCell.swift
//  IDExamples
//
//  Created by Igor Dorofix on 7/28/17.
//  Copyright © 2017 ID. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: Identifiable>(for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.identifier(), for: indexPath) as? T else {
            fatalError("Unexpected cell type at: \(indexPath)")
        }
        
        return cell
    }
}

extension UITableViewCell: Identifiable {
    static func identifier() -> String {
        return String(describing: self)
    }
}

extension UITableViewHeaderFooterView: Identifiable {
    static func identifier() -> String {
        return String(describing: self)
    }
}
