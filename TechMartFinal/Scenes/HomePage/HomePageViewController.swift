//
//  HomePageViewController.swift
//  TechMartFinal
//
//  Created by vu.thanh.long on 8/28/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import UIKit
import  RxDataSources

class HomePageViewController: UIViewController, BindableType {
    
    @IBOutlet private weak var tableView: UITableView!
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
    
    var viewModel: HomePageViewModel!
    var loadTrigger = PublishSubject<Void>()
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0,
                                                               width: self.view.frame.size.width,
                                                               height: 5))
    fileprivate let imageNames = ["slider3", "slider2"]
    fileprivate var numberOfItems = 2
    typealias HomeSectionModel = SectionModel<String, HomePageViewModel.CellInfo>
    fileprivate var dataSource: RxTableViewSectionedReloadDataSource<HomeSectionModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadTrigger.onNext(())
    }
    
    func configView() {
        title = "Home"
        searchBar.placeholder = "Nhập để tìm kiếm..."
        searchBar.barStyle = UIBarStyle.default
        searchBar.tintColor = UIColor.black
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.rightBarButtonItem = leftNavBarButton
        self.pagerView.automaticSlidingInterval = 3.0 - self.pagerView.automaticSlidingInterval
        self.pagerView.interitemSpacing = CGFloat(1) * 20
        let newScale = 0.5 + CGFloat(0.9) * 0.5
        self.pagerView.itemSize = self.pagerView.frame.size.applying(CGAffineTransform(scaleX: newScale, y: newScale))
        
        tableView.do {
            $0.register(cellType: DetailCategoryTableViewCell.self)
            $0.register(cellType: CategoryTableViewCell.self)
            $0.delaysContentTouches = false
            $0.delegate = self
        }
    }
    
    func bindViewModel() {
        let input = HomePageViewModel.Input(loadTrigger: loadTrigger.asDriverOnErrorJustComplete())
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
        
        self.dataSource = RxTableViewSectionedReloadDataSource<HomeSectionModel>(
            configureCell: { [weak self] (_, tableView, indexPath, cellInfo) -> UITableViewCell in
                let cell: UITableViewCell
                switch cellInfo.type {
                case .collection:
                    let cellData = tableView.dequeueReusableCell(
                        for: indexPath,
                        cellType: CategoryTableViewCell.self)
                    let tmp = BehaviorRelay<[Category]>(value: [])
                    tmp.accept(cellInfo.category)
                    cellData.configView(data: tmp)
                    cellData.selectedCell = {
                        print("selected")
                    }
                    cell = cellData
                case .tableView:
                    let cellInfo = tableView.dequeueReusableCell(
                        for: indexPath,
                        cellType: DetailCategoryTableViewCell.self)
                  //  cellInfo.configData()
                    cell = cellInfo
                }
                return cell
            }
        )
        
        output.sections
            .map {
                $0.map{ HomeSectionModel(model: $0.identifier, items: $0.cells) }
            }
            .drive(tableView.rx.items(dataSource: dataSource))
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

extension HomePageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
