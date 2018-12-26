//
//  Created by natai on 2018/12/4.
//  Copyright © 2018年 natai. All rights reserved.
//

import UIKit

extension UINavigationItem {
    private struct AssociatedKeys {
        static var staticLeftItemsMarginKey = "staticLeftItemsMarginKey"
        static var staticRightItemsMarginKey = "staticRightItemsMarginKey"
        static var staticLeftItemsSpacingKey = "staticLeftItemsSpacingKey"
        static var staticRightItemsSpacingKey = "staticRightItemsSpacingKey"
        static var staticFirstLeftItemToBackSpacingKey = "staticFirstLeftItemToBackSpacingKey"
        static var staticMinTitleContentViewMarginKey = "staticMinTitleContentViewMarginKey"
        
        static var leftItemsMarginKey = "leftItemsMarginKey"
        static var rightItemsMarginKey = "rightItemsMarginKey"
        static var leftItemsSpacingKey = "leftItemsSpacingKey"
        static var rightItemsSpacingKey = "rightItemsSpacingKey"
        static var firstLeftItemToBackSpacingKey = "firstLeftItemToBackSpacingKey"
        static var minTitleContentViewMarginKey = "minTitleContentViewMarginKey"
    }
    
    private enum ItemsPosition {
        case left(items: [UIBarButtonItem])
        case right(items: [UIBarButtonItem])
    }
    
    public static var leftItemsMargin: CGFloat {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.staticLeftItemsMarginKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.staticLeftItemsMarginKey) as? CGFloat ?? UINavigationItem.systemBarButtonItemsMargin
        }
    }
    
    /// rightBarButtonItems 到屏幕边缘的距离
    public static var rightItemsMargin: CGFloat {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.staticRightItemsMarginKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            let rawValue = objc_getAssociatedObject(self, &AssociatedKeys.staticRightItemsMarginKey) as? CGFloat ?? UINavigationItem.systemBarButtonItemsMargin
            if Device.isNotchScreen, Device.isHorizontalScreen {
                return rawValue + Device.safeAreaWidth
            } else {
                return rawValue
            }
        }
    }
    /// leftBarButtonItems 中各个 item 的距离
    public static var leftItemsSpacing: CGFloat {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.staticLeftItemsSpacingKey, max(newValue, 0), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.staticLeftItemsSpacingKey) as? CGFloat ?? UINavigationItem.systemItemsSpacing
        }
    }
    /// rightBarButtonItems 中各个 item 的距离
    public static var rightItemsSpacing: CGFloat {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.staticRightItemsSpacingKey, max(newValue, 0), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.staticRightItemsSpacingKey) as? CGFloat ?? UINavigationItem.systemItemsSpacing
        }
    }
    /// 第一个 leftBarButtonItem 到 backBarButtonItem 的距离
    public static var firstLeftItemToBackSpacing: CGFloat? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.staticFirstLeftItemToBackSpacingKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.staticFirstLeftItemToBackSpacingKey) as? CGFloat
        }
    }
    /// titleView 到 leftBarButtonItems、rightBarButtonItems 的距离
    public static var minTitleContentViewMargin: CGFloat {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.staticMinTitleContentViewMarginKey, max(newValue, 0) as CGFloat?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.staticMinTitleContentViewMarginKey) as? CGFloat ?? UINavigationItem.systemTitleContentViewMargin
        }
    }
    
    /// leftBarButtonItems、rightBarButtonItems 到屏幕边缘的系统默认距离
    static var systemBarButtonItemsMargin: CGFloat {
        if Device.isHorizontalScreen {
            return 8 + 12
        } else {
            if UIScreen.main.bounds.width <= 375 {
                return 8 + 8
            } else {
                return 8 + 12
            }
        }
    }
    
    /// leftBarButtonItems、rightBarButtonItems 中各个 item 的系统默认距离
    private static var systemItemsSpacing: CGFloat {
        return 8
    }
    /// titleView 到 leftBarButtonItems、rightBarButtonItems 的系统默认距离
    private static var systemTitleContentViewMargin: CGFloat {
        return 6
    }
    
    /// leftBarButtonItems 到屏幕边缘的距离
    public var leftItemsMargin: CGFloat {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.leftItemsMarginKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.leftItemsMarginKey) as? CGFloat ?? UINavigationItem.leftItemsMargin
        }
    }
    /// rightBarButtonItems 到屏幕边缘的距离
    public var rightItemsMargin: CGFloat {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.rightItemsMarginKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let rawValue = objc_getAssociatedObject(self, &AssociatedKeys.rightItemsMarginKey) as? CGFloat {
                if Device.isNotchScreen, Device.isHorizontalScreen {
                    return rawValue + Device.safeAreaWidth
                } else {
                    return rawValue
                }
            } else {
                return UINavigationItem.rightItemsMargin
            }
        }
    }
    /// leftBarButtonItems 中各个 item 的距离
    public var leftItemsSpacing: CGFloat {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.leftItemsSpacingKey, max(newValue, 0), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.leftItemsSpacingKey) as? CGFloat ?? UINavigationItem.leftItemsSpacing
        }
    }
    /// rightBarButtonItems 中各个 item 的距离
    public var rightItemsSpacing: CGFloat {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.rightItemsSpacingKey, max(newValue, 0), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.rightItemsSpacingKey) as? CGFloat ?? UINavigationItem.rightItemsSpacing
        }
    }
    /// 第一个 leftBarButtonItem 到 backBarButtonItem 的距离
    public var firstLeftItemToBackSpacing: CGFloat {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.firstLeftItemToBackSpacingKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.firstLeftItemToBackSpacingKey) as? CGFloat ?? systemFirstLeftItemToBackSpacing
        }
    }
    /// titleView 到 leftBarButtonItems、rightBarButtonItems 的距离
    public var minTitleContentViewMargin: CGFloat {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.minTitleContentViewMarginKey, max(newValue, 0) as CGFloat?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.minTitleContentViewMarginKey) as? CGFloat ?? UINavigationItem.minTitleContentViewMargin
        }
    }

    /// backButtonGuide.trailing 和 UINavigationBarContentView.leading 的间距
    var backButtonGuideTrailingConstant: CGFloat {
        var constant: CGFloat
        if Device.isHorizontalScreen {
            constant = 12
        } else {
            constant = 8
        }
        // 自定义视图后 _UIModernBarButton 到父视图间距的 8pt 就会消失, 同时 backButtonGuide.trailing 和 UINavigationBarContentView.leading 的间距增加 8pt
        if leftBarButtonItems?.first?.customView != nil {
            constant += 8
        }
        return constant
    }
    
    /// 第一个 leftBarButtonItem 到 backBarButtonItem 的系统默认距离
    private var systemFirstLeftItemToBackSpacing: CGFloat {
        if let spacing = UINavigationItem.firstLeftItemToBackSpacing {
            return spacing
        }
        // 自定义视图后 _UIModernBarButton 到父视图间距的 8pt 就会消失, 同时 backButtonGuide.trailing 和 UINavigationBarContentView.leading 的间距增加 8pt
        if leftBarButtonItems?.first?.customView != nil {
            return 6
        } else {
            return 6 + 8
        }
    }
}
