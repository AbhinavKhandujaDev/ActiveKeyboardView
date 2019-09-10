//
//  ViewController.swift
//  ActiveKeyboardView
//
//  Created by abhinav khanduja on 11/09/19.
//  Copyright © 2019 abhinav khanduja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        resignFirstResponder()
    }


}

