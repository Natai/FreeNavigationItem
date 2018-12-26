//
//  Created by natai on 2018/12/24.
//  Copyright © 2018年 natai. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let orangeView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 100, height: 30))
        orangeView.backgroundColor = UIColor.orange
        navigationItem.titleView = orangeView
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 30))
        view.backgroundColor = UIColor.cyan
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: view)]
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationItem.titleView?.frame.size.width = UIScreen.main.bounds.width - 100
    }
}
