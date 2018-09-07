//
//  DetailProductionViewController.swift
//  TechMartFinal
//
//  Created by nguyen.dong.son on 8/29/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//
import UIKit
import RxDataSources

class DetailProductionViewController: UIViewController, BindableType {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var productNameLabel: NSLayoutConstraint!
    @IBOutlet weak var productDetailLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    typealias DetailSectionModel = SectionModel<String, DetailProductionViewModel.CellInfo>
    fileprivate var dataSource: RxTableViewSectionedReloadDataSource<DetailSectionModel>!
    
    fileprivate let firstLoadTrigger = PublishSubject<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var viewModel: DetailProductionViewModel!
    
    func bindViewModel() {
        let input = DetailProductionViewModel.Input(firstLoadTrigger: firstLoadTrigger.asDriverOnErrorJustComplete().startWith(()))
        
        let output = viewModel.transform(input)
        
        output.indicator
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
        
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        
        self.dataSource = RxTableViewSectionedReloadDataSource<DetailSectionModel>(
            configureCell: { (_, tableView, indexPath, cellInfo) -> UITableViewCell in
                let cell: UITableViewCell
                switch cellInfo.type {
                case .imageDetail:
                    let cellInfo = tableView.dequeueReusableCell(
                        for: indexPath,
                        cellType: ImageDetailTableViewCell.self)
                    cell = cellInfo
                case .countProduct:
                    let cellInfo = tableView.dequeueReusableCell(
                        for: indexPath,
                        cellType: CountProductTableViewCell.self)
                    cellInfo.configData()
                    cell = cellInfo
                case .detailProduct:
                    let cellInfo = tableView.dequeueReusableCell(
                        for: indexPath,
                        cellType: InformationDetailTableViewCell.self)
                    cellInfo.configData()
                    cellInfo.seeMore = {
                        cellInfo.setSeeMore(state: $0)
                    }
                    cell = cellInfo
                }
                return cell
            }
        )
        
        output.sections
            .map {
                $0.map{ DetailSectionModel(model: $0.identifier, items: $0.cells) }
            }
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
    }
    
    func configView() {
        navigationItem.title = "Detail product"
        
        tableView?.do { [weak self] in
            $0.delaysContentTouches = false
            $0.register(cellType: ImageDetailTableViewCell.self)
            $0.register(cellType: CountProductTableViewCell.self)
            $0.register(cellType: InformationDetailTableViewCell.self)
            $0.estimatedRowHeight = 344
            $0.rowHeight = UITableViewAutomaticDimension
            $0.delegate = self
        }
        
        addToCartButton.do {
            $0.layer.cornerRadius = 5
            $0.layer
            .setGradientForUIView(UIColor.colorWithHexaCode("ed0000"),
                                UIColor.colorWithHexaCode("f26726"),
                                isCorner: true)
            $0.setImage(#imageLiteral(resourceName: "cart") , for: .normal)
        }
    }
}

extension DetailProductionViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard = Storyboards.product
}

extension DetailProductionViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
