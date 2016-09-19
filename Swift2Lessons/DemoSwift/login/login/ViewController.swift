//
//  ViewController.swift
//  login
//
//  Created by HoangThai on 5/16/16.
//  Copyright © 2016 techmaster. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tf_password: UITextField!
    @IBOutlet weak var tf_email: UITextField!
    
    
    
    var users  = ["nguyenvantu": "123", "nonghoangtai": "123456", "techmaster": "1"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func acction_DangNhap(sender: AnyObject) {
        if let password = users[tf_email.text!] {
            if (password == tf_password.text!) {
                print("Đăng nhập thành công")
            }
            else
            {
                print("Sai mật khẩu")
            }
        }
        else
        {
            print("Tài khoản không tồn tại")
        }
    }
    @IBAction func acction_DsNguoiDung(sender: AnyObject) {
        for (user, password) in users
        {
            print("Tài khoản:\(user) Mật khẩu:\(password)")
        }
        
    }
    
    
    
}

