//
//  aboutViewController.swift
//  csci571
//
//  Created by JIN QU on 27/11/2016.
//  Copyright © 2016 JIN QU. All rights reserved.
//

import UIKit

class aboutViewController: UIViewController {

    @IBAction func leftButton(_ sender: AnyObject) {
        self.slideMenuController()?.openLeft()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
