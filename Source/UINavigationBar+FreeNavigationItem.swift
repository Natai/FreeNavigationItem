//
//  Created by natai on 2018/12/4.
//  Copyright © 2018年 natai. All rights reserved.
//

import UIKit

extension UINavigationBar {
    private struct AssociatedKeys {
        static var backButtonWidthKey = "backButtonWidthKey"
        static var defaultMetricBackImageMarginKey = "defaultMetricBackImageMarginKey"
        static var compactMetricBackImageMarginKey = "compactMetricBackImageMarginKey"
    }

    /// 该属性生效时返回文字视图被移除，且 backButtonWidth 有最小值
    public static var backButtonWidth: CGFloat? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.backButtonWidthKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let rawValue = objc_getAssociatedObject(self, &AssociatedKeys.backButtonWidthKey) as? CGFloat {
                if Device.isNotchScreen, Device.isHorizontalScreen {
                    return rawValue + Device.safeAreaWidth
                } else {
                    return rawValue
                }
            } else {
                return nil
            }
        }
    }
    /// 竖屏时返回图片到屏幕边缘的距离
    public static var defaultMetricBackImageMargin: CGFloat {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.defaultMetricBackImageMarginKey, max(newValue, 0), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.defaultMetricBackImageMarginKey) as? CGFloat ?? UINavigationBar.systemBackImageMargin(barMetric: .default)
        }
    }
    /// 横屏时返回图片到屏幕边缘的距离
    public static var compactMetricBackImageMargin: CGFloat {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.compactMetricBackImageMarginKey, max(newValue, 0), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            let rawValue = objc_getAssociatedObject(self, &AssociatedKeys.compactMetricBackImageMarginKey) as? CGFloat ?? UINavigationBar.systemBackImageMargin(barMetric: .compact)
            if Device.isNotchScreen {
                return rawValue + Device.safeAreaWidth
            } else {
                return rawValue
            }
        }
    }
    /// 返回图片到屏幕边缘的距离
    public static var backImageMargin: CGFloat {
        set {
            defaultMetricBackImageMargin = newValue
            compactMetricBackImageMargin = newValue
        }
        get {
            if Device.isHorizontalScreen {
                return UINavigationBar.compactMetricBackImageMargin
            } else {
                return UINavigationBar.defaultMetricBackImageMargin
            }
        }
    }
    
    static var barMetricIgnorePrompt: UIBarMetrics {
        switch UIApplication.shared.statusBarOrientation {
        case .portrait, .portraitUpsideDown, .unknown:
            return UIBarMetrics.default
        case .landscapeLeft, .landscapeRight:
            return UIBarMetrics.compact
        }
    }
        
    public static func freeNavigationItems() {
        NSObject.swizzleNavigationBarContentView()
        NSObject.swizzleButtonBarButton()
    }
    
    public static func systemBackImageMargin(barMetric: UIBarMetrics? = nil) -> CGFloat {
        let realBarMetric = barMetric ?? barMetricIgnorePrompt
        switch realBarMetric {
        case .default, .defaultPrompt:
            if UIScreen.main.bounds.width <= 375 {
                return 8
            } else {
                return 12
            }
        case .compact, .compactPrompt:
            if Device.isNotchScreen {
                return 12 + Device.safeAreaWidth
            } else {
                return 12
            }
        }
    }
}
