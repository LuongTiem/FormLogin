//
//  FormSignIn.swift
//  FormSign
//
//  Created by ReasonAmu on 7/14/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class FormSignIn: UIViewController,UITextFieldDelegate {
    
    

    @IBOutlet weak var _srollview: UIScrollView!
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!

    @IBOutlet weak var Line_Email: UIView!
  
    @IBOutlet weak var Line_Password: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtPassword.delegate = self
        self.txtEmail.delegate = self
    
        AddImageInTextFild()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ShowKeyboard), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HiddenKeyboard), name: UIKeyboardWillHideNotification, object: nil)
      
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
        
        
        //- replace color placehoder textfield 
        if let placeHolderEmail = txtEmail.placeholder {
            txtEmail.attributedPlaceholder = NSAttributedString(string: placeHolderEmail, attributes: [NSForegroundColorAttributeName : UIColor.lightGrayColor()])
        }
        if let placeHolderPass = txtPassword.placeholder {
            txtPassword.attributedPlaceholder = NSAttributedString(string: placeHolderPass, attributes: [NSForegroundColorAttributeName : UIColor.lightGrayColor()])
        }
        
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
        if (txtPassword == textField) {
            self.view.endEditing(true)
        }
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
        self.view.endEditing(true)
    }

    
    //-- Show and hidden keyboard 
    
    
    
    func ShowHiddenKeyboard(notification : NSNotification,show : Bool){
        
        if let userInfo  = notification.userInfo{
            
            let keyboardFrame = userInfo[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue()
        //    let isShowing = notification.name == UIKeyboardDidShowNotification
            let changeInHeight = (keyboardFrame!.height + 40) * (show ? 1 : 1 )
            _srollview.contentInset.bottom = changeInHeight
            _srollview.scrollIndicatorInsets.bottom = changeInHeight
            
            UIView.animateWithDuration(0.25, animations: {
                self.view.updateFocusIfNeeded()
                }, completion: { (true) in
                   
            })
        }
        
    }
    
    func ShowKeyboard(notification :NSNotification) {
        ShowHiddenKeyboard(notification, show: true)
    }
    func HiddenKeyboard(notification : NSNotification){
        
        ShowHiddenKeyboard(notification, show: false)
    }
    
}
