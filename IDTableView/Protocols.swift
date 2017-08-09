//
//  Protocols.swift
//  IDExamples
//
//  Created by Igor Dorofix on 7/28/17.
//  Copyright © 2017 ID. All rights reserved.
//

import UIKit

protocol ConfigurableHeader {
    func configure(sectionBuilder: SectionBuilder)
    static func height(model: SectionBuilder, for bounds: CGRect) -> CGFloat
}

protocol HeaderViewDelegate: class {
    func didSelectHeader(_ headerView: TouchableHeader)
}

protocol TouchableHeader: class {
    var tag: Int {get set}
    var isHighlighted: Bool {get set}
    var delegate: HeaderViewDelegate? {get set}
}



protocol ConfigurableCell {
    associatedtype Model
    func configure(model: Model)
}

protocol NibLoadable {
    static func nibView<T: UIView>(viewType type: T.Type) -> T?
}

protocol Identifiable {
    static func identifier() -> String
}
