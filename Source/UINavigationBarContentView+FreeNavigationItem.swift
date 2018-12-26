//
//  Created by natai on 2018/12/14.
//  Copyright © 2018年 natai. All rights reserved.
//

import UIKit

extension NSObject {
    private var backButtonGuide: UILayoutGuide? {
        return value(forKeyPath: "_layout._backButtonGuide") as? UILayoutGuide
    }
    private var leadingBarGuide: UILayoutGuide? {
        return value(forKeyPath: "_layout._leadingBarGuide") as? UILayoutGuide
    }
    private var trailingBarGuide: UILayoutGuide? {
        return value(forKeyPath: "_layout._trailingBarGuide") as? UILayoutGuide
    }
    private var titleViewGuide: UILayoutGuide? {
        return value(forKeyPath: "_layout._titleViewGuide") as? UILayoutGuide
    }
    private var navigationBar: UINavigationBar? {
        return value(forKey: "superview") as? UINavigationBar
    }
    
    static func swizzleNavigationBarContentView() {
        _ = self.swizzleMethod
    }
    
    private static let swizzleMethod: Void = {
        guard let contentViewType = NSClassFromString("_UINavigationBarContentView") else { return }
        swizzlingForClass(contentViewType, originalSelectorName: "layoutSubviews", identifier:"_UINavigationBarContentView")
    }()
    
    @objc private func free_navigationitem__UINavigationBarContentView_layoutSubviews() {
        free_navigationitem__UINavigationBarContentView_layoutSubviews()
        updateConstraints()
    }
    
    private func updateConstraints() {
        guard let topItem = navigationBar?.topItem else { return }
        // leftBarButtonItems 中各个 item 的间距
        if let leftSpacingConstraint = value(forKeyPath: "_layout._leadingBar._minimumInterItemSpaceConstraint") as? NSLayoutConstraint {
            leftSpacingConstraint.constant = topItem.leftItemsSpacing
        }
        // rightBarButtonItems 中各个 item 的间距
        if let rightSpacingConstraint = value(forKeyPath: "_layout._trailingBar._minimumInterItemSpaceConstraint") as? NSLayoutConstraint {
            rightSpacingConstraint.constant = topItem.rightItemsSpacing
        }
        
        if let constraints = value(forKey: "constraints") as? [NSLayoutConstraint] {
            // 8pt 为第一个 _UIModernBarButton 到父视图的间距
            let firstModernButtonMargin: CGFloat = 8
            var leftStackToBackSpacing: CGFloat?
            let isFirstLeftItemCustomed = topItem.leftBarButtonItems?.first?.customView != nil
            constraints.forEach { constraint in
                // backButtonGuide.trailing 距 self.leading 有固定距离
                if constraint.firstItem === backButtonGuide,
                   constraint.secondItem === self,
                   constraint.firstAttribute == .trailing {
                    if navigationBar?.backItem == nil,
                       (topItem.leftBarButtonItems == nil || topItem.leftBarButtonItems?.isEmpty == true) {
                        if Device.isNotchScreen, Device.isHorizontalScreen {
                            constraint.constant = topItem.leftItemsMargin + Device.safeAreaWidth
                        } else {
                            constraint.constant = topItem.leftItemsMargin
                        }
                    }
                }

                // leadingBarGuide.leading 到 backButtonGuide.trailing 的约束
                if constraint.firstItem === leadingBarGuide,
                   constraint.secondItem === backButtonGuide,
                   constraint.firstAttribute == .leading {
                    if navigationBar?.backItem == nil {
                        constraint.constant = topItem.leftItemsMargin - UINavigationItem.systemBarButtonItemsMargin
                    } else {
                        if isFirstLeftItemCustomed {
                            constraint.constant = topItem.firstLeftItemToBackSpacing
                        } else {
                            constraint.constant = topItem.firstLeftItemToBackSpacing - firstModernButtonMargin
                        }
                    }
                    leftStackToBackSpacing = constraint.constant
                }
                
                // trailingBarGuide.trailing 到 self.trailing 的约束
                if constraint.firstItem === trailingBarGuide,
                   constraint.secondItem === self,
                   constraint.firstAttribute == .trailing {
                    let isFirstrightItemCustomed = topItem.rightBarButtonItems?.first?.customView != nil
                    if isFirstrightItemCustomed {
                        constraint.constant = -topItem.rightItemsMargin
                    } else {
                        constraint.constant = -(topItem.rightItemsMargin -  firstModernButtonMargin)
                    }
                    if topItem.rightBarButtonItems == nil || topItem.rightBarButtonItems?.isEmpty == true,
                       Device.isNotchScreen, Device.isHorizontalScreen {
                        constraint.constant = -topItem.rightItemsMargin
                    }
                }
                
                // title 左侧约束
                if constraint.firstItem === titleViewGuide, constraint.secondItem === leadingBarGuide {
                    // leftBarButtonItems 为空时， 忽略 leftToBackSpacing
                    if (topItem.leftBarButtonItems == nil || topItem.leftBarButtonItems?.isEmpty == true),
                       let leftStackToBackSpacing = leftStackToBackSpacing, leftStackToBackSpacing < 0 {
                        constraint.constant = topItem.minTitleContentViewMargin - leftStackToBackSpacing
                    } else {
                        constraint.constant = topItem.minTitleContentViewMargin
                    }
                }
                // title 右侧约束
                if constraint.firstItem === trailingBarGuide, constraint.secondItem === titleViewGuide {
                    constraint.constant = topItem.minTitleContentViewMargin
                }
            }
        }
    }
}
