//
//  ImageDetailTableViewCell.swift
//  TechMartFinal
//
//  Created by nguyen.dong.son on 8/29/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import UIKit

class ImageDetailTableViewCell: UITableViewCell, NibReusable {
    fileprivate let imageNames = ["slider3", "slider2"]
    fileprivate var numberOfItems = 2
    
    @IBOutlet private weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerView.itemSize = .zero
        }
    }
    @IBOutlet private weak var pageControl: FSPageControl! {
        didSet {
            self.pageControl.numberOfPages = self.imageNames.count
            self.pageControl.contentHorizontalAlignment = .center
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var costSaleLabel: UILabel!
    @IBOutlet weak var salePecentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    func configView() {
        pagerView.delegate = self
        pagerView.dataSource = self
        self.pagerView.automaticSlidingInterval = 3.0 - self.pagerView.automaticSlidingInterval
        self.pagerView.interitemSpacing = CGFloat(1) * 20
        let newScale = 0.5 + CGFloat(0.9) * 0.5
        self.pagerView.itemSize = self.pagerView.frame.size.applying(CGAffineTransform(scaleX: newScale, y: newScale))
        
        salePecentLabel.do {
            $0.font = UIFont.hiraginoSans(size: 13.0)
            $0.layer.cornerRadius = 4
        }
    }
}

extension ImageDetailTableViewCell: FSPagerViewDataSource,FSPagerViewDelegate {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageNames.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.textLabel?.text = ""
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        self.pageControl.currentPage = index
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        guard self.pageControl.currentPage != pagerView.currentIndex else {
            return
        }
        self.pageControl.currentPage = pagerView.currentIndex
    }
}
