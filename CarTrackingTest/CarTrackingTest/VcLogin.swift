//
//  ViewController.swift
//  CarTrackingTest
//
//  Created by M-Hashem on 1/30/17.
//  Copyright © 2017 M-Hashem. All rights reserved.
//

import UIKit
import Hue
import Toast_Swift
import MBProgressHUD

class VcLogin: UIViewController, UITextFieldDelegate{

    static var UserName = "";
    static var Password = "";
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPassword: UITextField!

    @IBOutlet weak var BtnLogin: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        Styler.BorderRad(target: BtnLogin, Radus: 3, borderWidth: 0)
        
        Styler.BorderRad(target: userName, Radus: 3, borderWidth: 1, BorderColor: UIColor(hex: "EEAE24"))
        Styler.BorderRad(target: userPassword, Radus: 3, borderWidth: 1, BorderColor: UIColor(hex: "EEAE24"))
        
        userName.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        userPassword.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    @IBAction func actionLogin(_ sender: Any)
    {
        let loading = MBProgressHUD.showAdded(to: self.view, animated: true)
        DAL.SharedLoginDal.Login(Username: userName.text!, passWord: userPassword.text!, callback: {(sucess, message) in
            loading.hide(animated: true)
            if (!sucess)
            {
                self.view.makeToast(message)
            }
            else
            {
                VcLogin.UserName = self.userName.text!;
                VcLogin.Password = self.userPassword.text!;
                
                AppDelegate.RoutToScreen(screen: "VcHome")
                
            }
            
        }
        )
        
    }
    func textFieldDidChange()
    {
        BtnLogin.isEnabled = (userName.text?.characters.count)! > 0 && (userPassword.text?.characters.count)! > 0
        
    }
    
    
}

