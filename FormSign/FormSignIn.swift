//
//  FormSignIn.swift
//  FormSign
//
//  Created by ReasonAmu on 7/14/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class FormSignIn: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!

    @IBOutlet weak var Line_Email: UIView!
  
    @IBOutlet weak var Line_Password: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtPassword.delegate = self
        self.txtEmail.delegate = self
        AddImageInTextFild()
    }

    
    func AddImageInTextFild(){
        
        let img_Email = UIImageView(image: UIImage(named: "user"))
        img_Email.frame = CGRectMake(0, 0, 40, txtEmail.frame.height)
        
        txtEmail.leftView = img_Email
        txtEmail.leftView?.contentMode = UIViewContentMode.Center
        txtEmail.leftViewMode  = UITextFieldViewMode.Always
        
        
        let img_Pass = UIImageView(image: UIImage (named: "pass"))
        img_Pass.frame = CGRectMake(0, 0, 40, txtPassword.frame.height)
        
        txtPassword.leftView = img_Pass
        txtPassword.leftView?.contentMode = UIViewContentMode.Center
        txtPassword.leftViewMode = UITextFieldViewMode.Always
        
        
    }
        
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if(textField == txtEmail) {
            txtEmail.leftViewMode = UITextFieldViewMode.Never
            Line_Email.backgroundColor = UIColor.whiteColor()
            return true
        }
        
        if(textField == txtPassword){
            txtPassword.leftViewMode = UITextFieldViewMode.Never
            Line_Password.backgroundColor = UIColor.whiteColor()
            return true
        }
        
         return false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        if(textField == txtEmail){
            txtEmail.leftViewMode = UITextFieldViewMode.Always
            Line_Email.backgroundColor = UIColor.lightGrayColor()
        }
        if(textField == txtPassword){
            txtPassword.leftViewMode = UITextFieldViewMode.Always
            Line_Password.backgroundColor = UIColor.lightGrayColor()
            
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if(textField == txtEmail ){
            txtPassword.becomeFirstResponder()
            
        }
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
        self.view.endEditing(true)
    }

}
