//
//  TestViewController.swift
//  iOSAppKitExample
//
//  Created by Towhid Islam on 5/3/18.
//  Copyright © 2018 Towhid Islam. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
