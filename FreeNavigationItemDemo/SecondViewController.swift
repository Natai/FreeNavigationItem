//
//  Created by natai on 2018/12/24.
//  Copyright © 2018年 natai. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftItemsSupplementBackButton = true
        
        let orangeView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 100, height: 30))
        orangeView.backgroundColor = UIColor.orange
        navigationItem.titleView = orangeView
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 30))
        view.backgroundColor = UIColor.red
        let view2 = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 30))
        view2.backgroundColor = UIColor.cyan
        let view3 = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 30))
        view3.backgroundColor = UIColor.red
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: view)]
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: view2), UIBarButtonItem(customView: view3)]
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationItem.titleView?.frame.size.width = UIScreen.main.bounds.width - 100
    }
}
