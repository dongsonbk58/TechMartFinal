import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    var error: Binder<Error> {
        return Binder(base) { viewController, error in
            viewController.showError(message: error.localizedDescription)
        }
    }
    
    var isLoading: Binder<Bool> {
        return Binder(base) { viewController, isLoading in
            if isLoading {
                MKProgress.config.hudType = .radial
                MKProgress.config.hudColor = .black
                MKProgress.config.circleBorderColor = UIColor.white
                MKProgress.config.logoImage = #imageLiteral(resourceName: "logo")
                MKProgress.show()
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                    MKProgress.hide()
                }
            }
        }
    }
}
