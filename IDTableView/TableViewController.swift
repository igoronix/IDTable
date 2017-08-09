//
//  TableViewController.swift
//  IDExamples
//
//  Created by Igor Dorofix on 7/27/17.
//  Copyright © 2017 ID. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    var tableView: UITableView
    public var director: TableDirector
    
    init() {
        self.tableView = UITableView(frame: CGRect.zero, style: .grouped)
        
        self.director = TableDirector(tableView: self.tableView)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self.bottomLayoutGuide, attribute: .top, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute:.bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0))
    }
}
