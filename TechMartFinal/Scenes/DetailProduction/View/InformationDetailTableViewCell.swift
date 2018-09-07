//
//  InformationDetailTableViewCell.swift
//  TechMartFinal
//
//  Created by nguyen.dong.son on 8/31/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import UIKit

class InformationDetailTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var seeMoreButton: UIButton!
    @IBOutlet weak var detailHeightConstraint: NSLayoutConstraint!
    
    var check = true
    
    var seeMore: ((_ state: Bool) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configView() {

    }
    
    @IBAction func seeMoreAction(_ sender: UIButton) {
        seeMore?(check)
        check = !check
    }
    
    func configData() {
        
    }
    
    func setSeeMore(state: Bool) {
        if state {
            UIView.animate(withDuration: 4, animations: {
                let width = UIScreen.main.bounds.width - 16
                let height = self.detailLabel?.text?.heightWithConstrainedWidth(width: width) ?? 0
                print(height)
                self.detailHeightConstraint?.constant = height + 10
                self.seeMoreButton.setTitle("<< See Less", for: .normal)
            })
        } else {
            UIView.animate(withDuration: 4, animations: {
                self.detailHeightConstraint?.constant = 400
                print(400)
                self.seeMoreButton.setTitle("See More >>", for: .normal)
            })
        }
    }
}
