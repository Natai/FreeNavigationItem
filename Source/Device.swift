//
//  Created by natai on 2018/12/20.
//  Copyright © 2018年 natai. All rights reserved.
//

import UIKit

struct Device {
    static let safeAreaWidth: CGFloat = 44
    
    static var isNotchScreen: Bool {
        let nativeHeight = UIScreen.main.nativeBounds.height
        // https://developer.apple.com/library/archive/documentation/DeviceInformation/Reference/iOSDeviceCompatibility/Displays/Displays.html
        if nativeHeight == 2436 || nativeHeight == 2688 || nativeHeight == 1792 {
            return true
        } else {
            return false
        }
    }
    
    static var isHorizontalScreen: Bool {
        switch UIApplication.shared.statusBarOrientation {
        case .portrait, .portraitUpsideDown, .unknown:
            return false
        case .landscapeLeft, .landscapeRight:
            return true
        }
    }
}
