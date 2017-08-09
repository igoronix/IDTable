//
//  TableDirector.swift
//  IDExamples
//
//  Created by Igor Dorofix on 7/28/17.
//  Copyright © 2017 ID. All rights reserved.
//

import UIKit

class TableDirector: NSObject {
    
    fileprivate weak var tableView: UITableView?
    fileprivate var builders = [SectionBuilder]()
    fileprivate var expandedSections: Array<Int> = []
    
    var isEnableMultipleExpand = false
    
    init(tableView: UITableView) {
        super.init()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionFooterHeight = 0;
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView = tableView
    }
    
    func append(sectionBuilder: SectionBuilder) {
        builders.append(sectionBuilder)
        
        sectionBuilder.rowBuilders.forEach { builder in
            tableView?.register(builder.reuseableId.nib(), forCellReuseIdentifier: builder.reuseableId)
        }
        tableView?.register(sectionBuilder.reuseableHeaderId.nib(), forHeaderFooterViewReuseIdentifier: sectionBuilder.reuseableHeaderId)
    }
    
    fileprivate func collapseAllHeaders() {
        self.expandedSections.forEach({ sectionIndex in
            if let header = self.tableView?.headerView(forSection: sectionIndex) as? TouchableHeader {
                header.isHighlighted = false
            }
        })
        self.expandedSections.removeAll()
    }
}

extension TableDirector: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return builders.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionBuilder = self.builders[section]
        return sectionBuilder.rowBuilders.map({$0.itemsCount}).reduce(0, { x, y in x + y })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell = UITableViewCell()
        var currentRowIndex = indexPath.row
        
        for builderIndex in 0...self.builders[indexPath.section].rowBuilders.count {
            let rowBuilder = self.builders[indexPath.section].rowBuilders[builderIndex]
            if (currentRowIndex - rowBuilder.itemsCount + 1) <= 0 {
                
                cell = tableView.dequeueReusableCell(withIdentifier: rowBuilder.reuseableId, for: indexPath)
                rowBuilder.configure(cell: cell, itemIndex: currentRowIndex)
                break
            } else {
                currentRowIndex -= rowBuilder.itemsCount
            }
        }
        return cell
    }
}

extension TableDirector: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return expandedSections.contains(indexPath.section) ? UITableViewAutomaticDimension : 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.builders[section].headerHeight(for: tableView.bounds)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionBuilder = self.builders[section]
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: sectionBuilder.reuseableHeaderId) {
            header.tag = section
            sectionBuilder.configure(header: header)
            if let touchableHeader = header as? TouchableHeader {
                touchableHeader.delegate = self
                touchableHeader.isHighlighted = expandedSections.contains(section)
            }
            return header
        }
        return UITableViewHeaderFooterView()
    }
}

extension TableDirector: HeaderViewDelegate {
    
    func didSelectHeader(_ headerView: TouchableHeader) {
        UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.85, initialSpringVelocity: 0.05, options: [.curveEaseInOut], animations: {
            if let index = self.expandedSections.index(of: headerView.tag) {
                headerView.isHighlighted = false
                self.expandedSections.remove(at: index)
            } else {
                if self.isEnableMultipleExpand {
                    self.collapseAllHeaders()
                }
                headerView.isHighlighted = true
                self.expandedSections.append(headerView.tag)
            }
            self.tableView?.beginUpdates()
            self.tableView?.endUpdates()
        }, completion: {finished in })
    }
}
