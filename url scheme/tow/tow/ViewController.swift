//
//  ViewController.swift
//  tow
//
//  Created by Songwen Ding on 2017/11/24.
//  Copyright © 2017年 Songwen Ding. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func action(_ sender: Any) {
        guard let url = URL(string: "one://") else {
            print("two call one:// fail")
            return
        }
        print(UIApplication.shared.canOpenURL(url))
        UIApplication.shared.open(url, options: ["key": "form two"], completionHandler: { (complete) in
            print(complete)
        })
    }
    

}

