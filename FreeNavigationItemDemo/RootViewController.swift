//
//  Created by natai on 2018/12/24.
//  Copyright © 2018年 natai. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
        textField.borderStyle = .line
        textField.placeholder = "FreeNavigationItem"
        navigationItem.titleView = textField
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationItem.titleView?.frame.size.width = UIScreen.main.bounds.width
    }
    
    @IBAction func unwindToRootController(segue: UIStoryboardSegue) { }

}

