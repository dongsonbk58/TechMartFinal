//
//  HomePageViewController.swift
//  TechMartFinal
//
//  Created by vu.thanh.long on 8/28/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController, BindableType {

    var viewModel: HomePageViewModel!
    
    @IBOutlet private weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerView.itemSize = .zero
        }
    }
    @IBOutlet private weak var pageControl: FSPageControl! {
        didSet {
            self.pageControl.numberOfPages = self.imageNames.count
            self.pageControl.contentHorizontalAlignment = .right
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }
    
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0,
                                                               width: self.view.frame.size.width,
                                                               height: 5))
    fileprivate let imageNames = ["slider1", "slider2"]
    fileprivate var numberOfItems = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
        title = "Home"
        searchBar.placeholder = "Nhập để tìm kiếm..."
        searchBar.barStyle = UIBarStyle.black
        searchBar.tintColor = UIColor.white
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.rightBarButtonItem = leftNavBarButton
        self.pagerView.automaticSlidingInterval = 3.0 - self.pagerView.automaticSlidingInterval
        self.pagerView.interitemSpacing = CGFloat(1) * 20
        let newScale = 0.5 + CGFloat(0.9) * 0.5
        self.pagerView.itemSize = self.pagerView.frame.size.applying(CGAffineTransform(scaleX: newScale, y: newScale))
    }
    
    func bindViewModel() {
        let trigger = NotificationCenter.default.rx.notification(Notification.Name.changeTab)
            .map {
                $0.object as? TabBarItemType
            }
            .unwrap()
            .distinctUntilChanged()
            .filter { $0 == TabBarItemType.home }
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        let input = HomePageViewModel.Input(loadTrigger: trigger)
        let output = viewModel.transform(input)
        output.data
            .drive()
            .disposed(by: rx.disposeBag)
        output.loading
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
    }
}

extension HomePageViewController: FSPagerViewDataSource,FSPagerViewDelegate {
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

extension HomePageViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard = Storyboards.home
}
