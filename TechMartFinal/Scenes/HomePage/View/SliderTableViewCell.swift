//
//  SliderTableViewCell.swift
//  TechMartFinal
//
//  Created by vu.thanh.long on 9/7/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import UIKit

class SliderTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerView.itemSize = .zero
        }
    }
    
    @IBOutlet weak var pageControl: FSPageControl! {
        didSet {
            self.pageControl.numberOfPages = self.imageNames.count
            self.pageControl.contentHorizontalAlignment = .right
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }
    
    fileprivate let imageNames = ["slider3", "slider2"]
    fileprivate var numberOfItems = 2
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    func configView() {
        pagerView.delegate = self
        pagerView.dataSource = self
        self.pagerView.automaticSlidingInterval = 3.0 - self.pagerView.automaticSlidingInterval
        self.pagerView.interitemSpacing = 10
        let newScale = 1.15
        self.pagerView.itemSize = self.pagerView.frame.size.applying(CGAffineTransform(scaleX: CGFloat(newScale), y: CGFloat(newScale)))
    }
}
extension SliderTableViewCell: FSPagerViewDataSource,FSPagerViewDelegate {
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

