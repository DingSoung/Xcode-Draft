//
//  TargetViewController.swift
//  transparentVC
//
//  Created by Songwen Ding on 2017/11/26.
//  Copyright © 2017年 Songwen Ding. All rights reserved.
//

import UIKit

class TargetViewController: UIViewController {

    let subView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.subView.backgroundColor = UIColor.yellow
        
        self.view.addSubview(self.subView)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image : nil, style: UIBarButtonItemStyle.plain, target: self, action: #selector(TargetViewController.backBarButtonItemAction(sender:)))
            
        self.view.backgroundColor = UIColor.clear
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.subView.frame = CGRect(x: 10, y: 100, width: 100, height: 100)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func backBarButtonItemAction(sender: UIBarButtonItemStyle) {
        if let navi = self.navigationController, navi.viewControllers.count > 1 {
            navi.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
