//
//  topView.swift
//  csci571
//
//  Created by JIN QU on 24/11/2016.
//  Copyright © 2016 JIN QU. All rights reserved.
//

import UIKit

class ViewController: SlideMenuController {
    
    override func awakeFromNib() {
        if let mainController = self.storyboard?.instantiateViewController(withIdentifier:"legislators"){
            self.mainViewController = mainController
        }
        
        if let leftController = self.storyboard?.instantiateViewController(withIdentifier: "left"){
            self.leftViewController = leftController
        }
        super.awakeFromNib()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

