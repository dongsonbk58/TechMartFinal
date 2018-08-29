//
//  OtherViewController.swift
//  TechMartFinal
//
//  Created by nguyen.dong.son on 8/28/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//
import UIKit
import RxDataSources
import SDWebImage

final class OtherViewController: UIViewController, BindableType {
    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias MenuSectionModel = SectionModel<OtherViewModel.MenuSection, OtherViewModel.MenuItem>
    var viewModel: OtherViewModel!
    private var options = Options()
    
    // MARK: - Private properties
    fileprivate var refreshControl: UIRefreshControl = UIRefreshControl()
    fileprivate var dataSource: RxCollectionViewSectionedReloadDataSource<MenuSectionModel>?
    fileprivate var newProfileImage = PublishSubject<UIImage>()
    fileprivate var newCoverImage = PublishSubject<UIImage>()
    fileprivate var screenSize = UIScreen.main.bounds.size
    fileprivate var cacheUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func configView() {
        title = "Other"
        
        collectionView.do {
            $0.register(cellType: MenuCell.self)
            $0.register(supplementaryViewType: UserProfileView.self,
                        ofKind: UICollectionElementKindSectionHeader)
            $0.alwaysBounceVertical = true
        }
        collectionView.addSubview(refreshControl)
    }
    
    deinit {
        logDeinit()
    }
    
    func bindViewModel() {
        let trigger = NotificationCenter.default.rx.notification(Notification.Name.changeTab)
            .map {
                $0.object as? TabBarItemType
            }
            .unwrap()
            .distinctUntilChanged()
            .filter { $0 == TabBarItemType.other }
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        
        let refreshTrigger = refreshControl.rx.controlEvent(.valueChanged).asDriver()
        
        let input = OtherViewModel.Input(
            loadTrigger: trigger,
            reloadTrigger: refreshTrigger,
            newProfileImage: newProfileImage.asDriverOnErrorJustComplete(),
            menuTrigger: collectionView.rx.itemSelected.asDriver())
        
        let output = viewModel.transform(input)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<MenuSectionModel>(
            configureCell: { dataSource, collectionView, indexPath, menuItem in
                return collectionView.dequeueReusableCell(for: indexPath, cellType: MenuCell.self)
                    .then {
                        $0.menuLabel.text = menuItem.type.title
                        $0.menuImageView.image = menuItem.type.image
                }
        },
            configureSupplementaryView: { [weak self] dataSource, collectionView, _, indexPath in
                let view = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionElementKindSectionHeader,
                    for: indexPath,
                    viewType: UserProfileView.self)
                let section = dataSource[indexPath.section]
                view.configView(with: section.model.user)
                return view
            }
        )
        output.menus
            .map { sections -> [MenuSectionModel] in
                sections.map { MenuSectionModel(model: $0, items: $0.items) }
            }
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        
        collectionView.rx
            .setDelegate(self)
            .disposed(by: rx.disposeBag)
        
        self.dataSource = dataSource
        output.loading
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
        output.reloading
            .drive(refreshControl.rx.isRefreshing)
            .disposed(by: rx.disposeBag)
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        output.selectedMenu
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

extension OtherViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard = Storyboards.home
}

extension OtherViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    fileprivate struct Options {
        var spaceBetweenCell = 8
        var itemsPerRow = 3
        var sectionInsets: UIEdgeInsets = UIEdgeInsets(
            top: 25.0,
            left: 30.0,
            bottom: 30.0,
            right: 30.0
        )
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingSpace = options.sectionInsets.left + options.sectionInsets.right + CGFloat((options.itemsPerRow - 1) * options.spaceBetweenCell)
        let availableWidth = screenSize.width - paddingSpace
        let widthPerItem = availableWidth / CGFloat(options.itemsPerRow)
        let heightPerItem = widthPerItem
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return options.sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: screenSize.width, height: 220)
    }
}
