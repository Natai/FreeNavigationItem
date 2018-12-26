//
//  Created by natai on 2018/12/4.
//  Copyright © 2018年 natai. All rights reserved.
//

import Foundation

extension NSObject {
    static func swizzlingForClass(_ type: AnyClass, originalSelector: Selector, identifier: String = "") {
        let text = identifier.isEmpty ? identifier : identifier + "_"
        let swizzledSelector = NSSelectorFromString("free_navigationitem_" + text + originalSelector.description)
        swizzlingForClass(type, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
    }
    
    static func swizzlingForClass(_ type: AnyClass, originalSelectorName: String, identifier: String = "") {
        let originalSelector = NSSelectorFromString(originalSelectorName)
        let text = identifier.isEmpty ? identifier : identifier + "_"
        let swizzledSelector = NSSelectorFromString("free_navigationitem_" + text + originalSelectorName)
        swizzlingForClass(type, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
    }
    
    private static func swizzlingForClass(_ type: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        guard let originalMethod = class_getInstanceMethod(type, originalSelector),
            let swizzledMethod = class_getInstanceMethod(type, swizzledSelector) else {
                return
        }
        
        let isAddSuccess = class_addMethod(type, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        if isAddSuccess {
            class_replaceMethod(type, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}
