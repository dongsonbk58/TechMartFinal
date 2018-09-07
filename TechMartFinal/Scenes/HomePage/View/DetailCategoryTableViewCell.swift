//
//  DetailCategoryTableViewCell.swift
//  TechMartFinal
//
//  Created by ThanhLong on 9/6/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import UIKit

class DetailCategoryTableViewCell: UITableViewCell, NibReusable {

   
    @IBOutlet private weak var categoryDetailTableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryDetailTableView.register(cellType: CategoryDetailTableViewCell.self)
    }
    
    func configView(data: BehaviorRelay<[CategoryDetail]>) {
        categoryDetailTableView.dataSource = nil
        _ = data.asObservable().bind(to: categoryDetailTableView.rx.items) { tableView, index, data in
            return tableView.dequeueReusableCell(for: IndexPath(row: index, section: 0),
                                                      cellType: CategoryDetailTableViewCell.self)
        }
    }
}
