//
//  LoginViewController.swift
//  musu
//
//  Created by 丁松 on 15/3/15.
//  Copyright (c) 2015年 丁松. All rights reserved.
//


import UIKit



class LoginViewController: UIViewController {
    let tmpPath = NSHomeDirectory() as String + "/tmp/Login/"
    
    @IBOutlet weak var UserNameTextDield: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var BackGroundImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tapGesture = UITapGestureRecognizer(target: self, action: "EndEditTapGesture:")
        tapGesture.numberOfTapsRequired = 1 //设置手势点击数,双击：点2下
        self.view.addGestureRecognizer(tapGesture)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func EndEditTapGesture(sender: AnyObject) {
        self.view.endEditing(true)
    }

    @IBAction func LoginButton(sender: AnyObject) {
        var ID = self.UserNameTextDield.text
        var password = self.PasswordTextField.text
        self.UserNameTextDield.text.writeToFile(tmpPath + "UserName", atomically: true, encoding: NSUTF8StringEncoding, error: nil)
        self.PasswordTextField.text.writeToFile(tmpPath + "Password", atomically: true, encoding: NSUTF8StringEncoding, error: nil)
        if(ID != "DingSoung" || password != "123456") {
            let alert = UIAlertView()
            alert.title = "alert"
            alert.delegate = self
            alert.addButtonWithTitle("OK")
            alert.message = "User name or password is Incorrect!"
            alert.show()
        }
    }
}