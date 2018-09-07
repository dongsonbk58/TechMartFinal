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
    var viewModel: HomePageViewModel!
    var loadTrigger = PublishSubject<Void>()
  
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0,
                                                               width: self.view.frame.size.width,
                                                               height: 5))
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
        
        tableView.do {
            $0.register(cellType: DetailCategoryTableViewCell.self)
            $0.register(cellType: CategoryTableViewCell.self)
            $0.register(cellType: SliderTableViewCell.self)
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
                    if cellInfo.category != nil {
                        tmp.accept(cellInfo.category!)
                    }
                    cellData.configView(data: tmp)
                    cellData.selectedCell = {
                        print("selected")
                    }
                    cell = cellData
                case .tableView:
                    let cellData = tableView.dequeueReusableCell(
                        for: indexPath,
                        cellType: DetailCategoryTableViewCell.self)
                    let tmp = BehaviorRelay<[CategoryDetail]>(value: [])
                    if cellInfo.categoryDetail != nil {
                        tmp.accept(cellInfo.categoryDetail!)
                    }
                    cellData.configView(data: tmp)
                    cell = cellData
                case .slider:
                    let cellData = tableView.dequeueReusableCell(
                        for: indexPath,
                        cellType: SliderTableViewCell.self)
                    cell = cellData
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
extension HomePageViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard = Storyboards.home
}

extension HomePageViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 190
        }
        if indexPath.section == 1 {
            return 450
        }
        return 1000
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
