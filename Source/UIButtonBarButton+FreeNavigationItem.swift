//
//  Created by natai on 2018/12/14.
//  Copyright © 2018年 natai. All rights reserved.
//

import UIKit

extension NSObject {
    static func swizzleButtonBarButton() {
        _ = self.swizzleMethod
    }
    
    private static let swizzleMethod: Void = {
        guard let contentViewType = NSClassFromString("_UIButtonBarButton") else { return }
        swizzlingForClass(contentViewType, originalSelectorName: "layoutSubviews", identifier:"_UIButtonBarButton")
        swizzlingForClass(contentViewType, originalSelectorName: "hitTest:withEvent:", identifier: "_UIButtonBarButton")
    }()
    
    @objc private func free_navigationitem__UIButtonBarButton_layoutSubviews() {
        free_navigationitem__UIButtonBarButton_layoutSubviews()
        guard let isBackButton = value(forKey: "_backButton") as? Bool, isBackButton == true,
              let constraints = value(forKey: "constraints") as? [NSLayoutConstraint],
              let modernBarButtonType = NSClassFromString("_UIModernBarButton"),
              let view = self as? UIView else { return }
        constraints.forEach { constraint in
            // 返回图片和父视图的距离
            if constraint.secondItem === self && constraint.secondAttribute == .leading {
                constraint.constant = UINavigationBar.backImageMargin
            }
            // 返回图片和返回文字的距离
            if constraint.firstItem?.isKind(of: modernBarButtonType) == true,
               constraint.secondItem?.isKind(of: modernBarButtonType) == true {
                if UINavigationBar.backButtonWidth != nil {
                    // 移除文字
                    constraint.firstItem?.removeFromSuperview()
                    return
                }
                
                // 6 为默认值，在自定义 backImageMargin 后为了保持文字位置不变，需要添加一个 UINavigationBar.systemBackImageMargin() - UINavigationBar.backImageMargin 的补偿间距
                let offsetX = UIBarButtonItem.appearance().backButtonTitlePositionAdjustment(for: UINavigationBar.barMetricIgnorePrompt).horizontal
                constraint.constant = 6 + UINavigationBar.systemBackImageMargin() - UINavigationBar.backImageMargin + offsetX
            }
        }

        let widthConstraint = constraints.filter { $0.identifier == "widthConstraint" }.first
        if let backButtonWidth = UINavigationBar.backButtonWidth {
            if let widthConstraint = widthConstraint {
                widthConstraint.constant = backButtonWidth
            } else {
                let widthConstraint = view.widthAnchor.constraint(equalToConstant: backButtonWidth)
                widthConstraint.identifier = "widthConstraint"
                widthConstraint.priority = UILayoutPriority.defaultHigh
                widthConstraint.isActive = true
            }
        }
    }
    
    @objc private func free_navigationitem__UIButtonBarButton_hitTest(_ point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        if let view = self as? UIView,
           let navigationBar = view.superview?.superview as? UINavigationBar,
           let topItem = navigationBar.topItem,
           topItem.leftItemsSupplementBackButton == true,
           point.x > view.frame.width {
            return nil
        }
        return free_navigationitem__UIButtonBarButton_hitTest(point, withEvent: event)
    }
}
