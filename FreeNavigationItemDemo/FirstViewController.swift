//
//  Created by natai on 2018/12/24.
//  Copyright © 2018年 natai. All rights reserved.
//

import UIKit
import FreeNavigationItem

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftItemsMargin = 10
        navigationItem.leftItemsSpacing = 2
        navigationItem.minTitleContentViewMargin = 4
        navigationItem.rightItemsMargin = 5
        navigationItem.rightItemsSpacing = 3
        navigationItem.firstLeftItemToBackSpacing = 1
        
        let orangeView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
        orangeView.backgroundColor = UIColor.orange
        navigationItem.titleView = orangeView
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 30))
        view.backgroundColor = UIColor.red
        let view2 = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 30))
        view2.backgroundColor = UIColor.cyan
        let view3 = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 30))
        view3.backgroundColor = UIColor.red
        let view4 = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 30))
        view4.backgroundColor = UIColor.cyan
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: view), UIBarButtonItem(customView: view2)]
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: view3), UIBarButtonItem(customView: view4)]
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationItem.titleView?.frame.size.width = UIScreen.main.bounds.width
    }
}
