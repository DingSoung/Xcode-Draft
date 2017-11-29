//
//  ViewController.swift
//  keyboard toolbar
//
//  Created by Songwen Ding on 2017/11/29.
//  Copyright © 2017年 Songwen Ding. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var numberToolbar: UIToolbar?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.numberToolbar = UIToolbar()
        self.numberToolbar?.barStyle = UIBarStyle.default
        self.numberToolbar?.items = [
            UIBarButtonItem(title: "1",
                            style: UIBarButtonItemStyle.plain,
                            target: self,
                            action: #selector(ViewController.keyboardBarButtomAction(sender:))),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace,
                            target: nil,
                            action: nil),
            
            UIBarButtonItem(title: "Done",
                            style: UIBarButtonItemStyle.plain,
                            target: self,
                            action: #selector(ViewController.keyboardBarButtomAction(sender:)))]
        self.textField.keyboardType = .asciiCapable
        self.textField.inputAccessoryView = numberToolbar
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.textField.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.numberToolbar?.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 50)
    }

    @objc func keyboardBarButtomAction(sender: UIBarButtonItem) {
        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

