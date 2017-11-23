//
//  ViewController.swift
//  Example
//
//  Created by Songwen Ding on 2017/11/23.
//  Copyright © 2017年 Songwen Ding. All rights reserved.
//

import UIKit
import DocsDetail

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let vc = DocsViewController()
        vc.url = URL(string: "https://www.baidu.com")
        self.present(vc, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

