//
//  OtherViewModel.swift
//  TechMartFinal
//
//  Created by nguyen.dong.son on 8/28/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

struct OtherViewModel: ViewModelType {
    let navigator: OtherNavigatorType
    let useCase: OtherUseCaseType
    
    struct Input {
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let newProfileImage: Driver<UIImage>
        let menuTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let reloading: Driver<Bool>
        let loading: Driver<Bool>
        let error: Driver<Error>
        let menus: Driver<[MenuSection]>
        let selectedMenu: Driver<MenuItem>
    }
    
    func transform(_ input: OtherViewModel.Input) -> OtherViewModel.Output {
        let activityIndicator = ActivityIndicator()
        let reloadActivityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()

        let fetchUser = input.loadTrigger.flatMapLatest {_ in
            return self.useCase.reloadUserInformation()
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
        }
        
        let reloadUser = input.reloadTrigger.flatMapLatest {_ in
            return self.useCase.reloadUserInformation()
                .trackActivity(reloadActivityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
        }
        
        let menus = Driver.merge(fetchUser, reloadUser)
            .map { user -> [MenuSection] in
                let menuItems = self.menuTypes().map { MenuItem(type: $0) }
                return [
                    MenuSection(user: user,
                                items: menuItems)
                ]
        }
        
        let selectedMenu = input.menuTrigger
            .withLatestFrom(menus) { indexPath, menus -> MenuItem? in
                if indexPath.row < menus[indexPath.section].items.count {
                    return menus[indexPath.section].items[indexPath.row]
                }
                return nil
            }
            .unwrap()
            .do(onNext: { menu in
                switch menu.type {
                case .barCode:
                    self.navigator.toBarCode()
                case .map, .settings, .updateProfile:
                    break
                }
                print(menu.type.title)
            })
        
        let loading = Driver.merge(activityIndicator.asDriver())
        
        return Output(
            reloading: reloadActivityIndicator.asDriver(),
            loading: loading,
            error: errorTracker.asDriver(),
            menus: menus,
            selectedMenu: selectedMenu
        )
    }
    
}

extension OtherViewModel {
    struct MenuItem {
        let type: MenuType
    }
    
    struct MenuSection {
        let user: User?
        let items: [MenuItem]
    }
    
    enum MenuType: Int {
        case barCode
        case settings
        case updateProfile
        case map
        
        static var all: [MenuType] {
            return  [ .barCode,
                      .updateProfile,
                      .map,
                      .settings
            ]
        }
        
        var title: String {
            switch self {
            case .barCode:
                return "Scan Barcode"
            case .updateProfile:
                return "Update Profile"
            case .map:
                return "Map".localized()
            case .settings:
                return "Settings"
            }
        }
        
        var image: UIImage {
            switch self {
            case .barCode:
                return #imageLiteral(resourceName: "qr-code-1")
            case .settings:
                return #imageLiteral(resourceName: "settings")
            case .map:
                return #imageLiteral(resourceName: "worldwide")
            case .updateProfile:
                return #imageLiteral(resourceName: "user")    
            }
        }
    }
    
    func menuTypes() -> [MenuType] {
        return MenuType.all
    }
}
