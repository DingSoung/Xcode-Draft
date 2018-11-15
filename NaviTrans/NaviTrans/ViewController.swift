//
//  ViewController.swift
//  NaviTrans
//
//  Created by Songwen on 2018/8/30.
//  Copyright © 2018 Songwen. All rights reserved.


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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let tab = UITabBarController()
        tab.title = "Tab"
        tab.viewControllers = [
            {
                let v = MyVC()
                v.title = "😄1"
                v.view.backgroundColor = .yellow
                return v
            }(),
            {
                let v = MyVC()
                v.title = "😄2"
                v.view.backgroundColor = .orange
                return v
            }(),
            {
                let v = MyVC()
                v.title = "😄3"
                v.view.backgroundColor = .red
                return v
            }()
        ]
        let navi = UINavigationController(rootViewController: tab)
        self.present(navi, animated: true, completion: nil)
    }
}

class MyVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange

        let button = UIButton()
        button.frame = CGRect(x: 20, y: 100, width: 50, height: 30)
        button.setTitle("push", for: .normal)
        button.addTarget(self, action: #selector(pushButtonAction(sender:)), for: .touchUpInside)
        self.view.addSubview(button)
    }

    @objc func pushButtonAction(sender: UIButton) {
        let vc = MyVC()
        if let t = self.title {
            vc.title = t + "😄"
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

