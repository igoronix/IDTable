//
//  ViewController.swift
//  IDTableView
//
//  Created by Igor Dorofix on 8/8/17.
//  Copyright © 2017 ID. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let tableViewController = TableViewController()
        let rowBuilder0 = TableRowBuider<ArtistModel, ArtistTableCell>(items:[ArtistModel("1"), ArtistModel("2"), ArtistModel("3"), ArtistModel("4"), ArtistModel("5")])
        
        let rowBuilder2 = TableRowBuider<AlbumModel, AlbumTableCell>(items:[AlbumModel("6"), AlbumModel("7"), AlbumModel("8")])
        let rowBuilder3 = TableRowBuider<ArtistModel, ArtistTableCell>(items:[ArtistModel("9"), ArtistModel("10"), ArtistModel("11"), ArtistModel("12")])
        
        let s0 = TableSectionBuilder<AlbumHeader>(title: "Pop", builders: [rowBuilder0])
        let s1 = TableSectionBuilder<AlbumHeader>(title: "Rock", builders: [rowBuilder2, rowBuilder3])
        
        tableViewController.director.append(sectionBuilder: s0)
        tableViewController.director.append(sectionBuilder: s1)
        
        self.present(tableViewController, animated: true, completion: nil)
    }
}

