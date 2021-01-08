//
//  UIApplication+Sweeter.swift
//
//  Created by Yonat Sharon on 2019-02-08.
//

import UIKit

extension UIApplication {
    /// Sweeter: `keyWindow` for scene-based apps
    public var legacyKeyWindow: UIWindow? {
        if #available(iOS 13, *) {
            return windows.first { $0.isKeyWindow }
        } else {
            return keyWindow
        }
    }

    /// Sweeter: Returns the currently top-most view controller.
    public class func swetter_topViewController(base: UIViewController? = UIApplication.shared.legacyKeyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return swetter_topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return swetter_topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return swetter_topViewController(base: presented)
        }
        return base
    }

    /// Sweeter: Show `viewController` over the top-most view controller.
    public class func present(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            swetter_topViewController()?.present(viewController, animated: animated, completion: completion)
        }
    }
}
