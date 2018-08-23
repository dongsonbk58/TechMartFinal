import UIKit

extension UIViewController {
    
    func showNotification(message: String) {
        StatusBarNotifications.show(withText: message,
                                    animation: .fade,
                                    backgroundColor: UIColor.black,
                                    textColor: UIColor.white)
    }
    
    func showError(message: String, completion: (() -> Void)? = nil) {
        let ac = UIAlertController(title: "Error",
                                   message: message,
                                   preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            completion?()
        }
        ac.addAction(okAction)
        present(ac, animated: true, completion: nil)
    }

    static func instantiateFromNib(atBundle bundleClass: AnyClass? = nil) -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            var bundle: Bundle? = nil
            if let bundleName = bundleClass {
                bundle = Bundle(for: bundleName)
            }
            return T.init(nibName: String(describing: T.self), bundle: bundle)
        }
        return instantiateFromNib()
    }
    
    func removeBackButtonTitle() {
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func topMostViewController() -> UIViewController? {
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController()
        }
        
        if let tab = self as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        
        if self.presentedViewController == nil {
            return self
        }
        if let navigation = self.presentedViewController as? UINavigationController {
            if let visibleController = navigation.visibleViewController {
                return visibleController.topMostViewController()
            }
        }
        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        return self.presentedViewController?.topMostViewController()
    }
    func showCloseAlert(_ title: String, _ message: String, _ closeAction: (() -> Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "CLOSE".localizedString, style: .default) { _ in
            closeAction?()
        }
        alertVC.addAction(closeAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    func showOkAlert(_ title: String, _ message: String, _ okAction: (() -> Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK".localizedString, style: .default) { _ in
            okAction?()
        }
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    func showOkCancelAlert(_ title: String, _ message: String, _ okAction: (() -> Void)?, _ cancelAction: (() -> Void)? = nil,
                           cancelBtnTitle: String = "CANCEL".localizedString,
                           okBtnTitle: String = "OK".localizedString) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okBtnTitle, style: .default) { _ in
            okAction?()
        }
        alertVC.addAction(okAction)
        let cancelAction = UIAlertAction(title: cancelBtnTitle, style: .default) { _ in
            cancelAction?()
        }
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    func showCancelOkAlert(_ title: String, _ message: String, _ okAction: (() -> Void)?, _ cancelAction: (() -> Void)? = nil,
                           cancelBtnTitle: String = "CANCEL".localizedString,
                           okBtnTitle: String = "OK".localizedString) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: cancelBtnTitle, style: .default) { _ in
            cancelAction?()
        }
        alertVC.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: okBtnTitle, style: .destructive) { _ in
            okAction?()
        }
        
        alertVC.addAction(okAction)
        
        present(alertVC, animated: true, completion: nil)
    }
    
    func showAlert(_ title: String, _ message: String, _ okTitle: String, _ okAction: (() -> Void)?, _ cancelTitle: String?, _ cancelAction: (() -> Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default) { _ in
            okAction?()
        }
        alertVC.addAction(okAction)
        if cancelTitle != nil {
            let cancelAction = UIAlertAction(title: cancelTitle!, style: .default) { _ in
                cancelAction?()
            }
            alertVC.addAction(cancelAction)
        }
        present(alertVC, animated: true, completion: nil)
    }
    
    func showErrorAlert(_ message: String? = nil, action: (() -> Void)? = nil) {
        showOkAlert("ERROR".localizedString, message ?? "", action)
    }
    
    func showErrorAlert(_ error: Error?, action: (() -> Void)? = nil) {
        showErrorAlert(error?.localizedDescription, action: action)
    }
    
    func showMessage(_ message: String?) {
        let alertView = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        present(alertView, animated: true, completion: nil)
    }
}
