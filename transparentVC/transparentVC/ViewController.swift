//
//  ViewController.swift
//  transparentVC
//
//  Created by Songwen Ding on 2017/11/26.
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

    @IBAction func push(_ sender: Any) {
        self.navigationController?.modalPresentationStyle = UIModalPresentationStyle.currentContext;
        self.navigationController?.pushViewController(TargetViewController(), animated: true)
    }
    
    @IBAction func present(_ sender: Any) {
        
        self.modalPresentationStyle = UIModalPresentationStyle.currentContext;
        self.present(TargetViewController(), animated: true, completion: nil)
    }
}

