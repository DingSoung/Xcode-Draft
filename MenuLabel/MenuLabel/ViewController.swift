//
//  ViewController.swift
//  MenuLabel
//
//  Created by Songwen on 2018/9/7.
//  Copyright © 2018 Songwen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let label = MyLabel()
        label.isUserInteractionEnabled = true
        label.backgroundColor = UIColor.orange
        label.text = "哈哈哈哈哈哈哈哈哈哈"
        view.addSubview(label)
        label.frame = CGRect(x: 100, y: 200, width: 200, height: 100)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

