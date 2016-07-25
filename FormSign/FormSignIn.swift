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
    
    @IBOutlet weak var btnAction: UIButton!
    @IBOutlet weak var txtPassword: UITextField!

    @IBOutlet weak var Line_Email: UIView!
  
    @IBOutlet weak var Line_Password: UIView!
    
    var USER:Dictionary = ["luongtiem": "123","trunghop" : "456", "kienngo" : "asdf"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtPassword.delegate = self
        self.txtEmail.delegate = self
        
        btnAction.backgroundColor = UIColor.clearColor()
        btnAction.layer.borderColor = UIColor.whiteColor().CGColor
        btnAction.layer.borderWidth = 1
        btnAction.enabled = false
        AddImageInTextFild()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ShowHiddenKeyboard), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ShowHiddenKeyboard), name: UIKeyboardWillHideNotification, object: nil)
        
       
       TapGuestRecognizer()
      
    }
    
    
    //-- Tap
    func TapGuestRecognizer(){
        
        let  tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapScreen))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func tapScreen(){
        
        self.view.endEditing(true)
        
    }
    
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
         self.navigationController?.navigationBarHidden = true
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
           txtPassword.resignFirstResponder()
            btnOK()
          
        }
        return true
    }
  
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
         textField.addTarget(self, action: #selector(FormSignIn.checkKiTu), forControlEvents: UIControlEvents.EditingChanged)
        return true
    }
    
    func checkKiTu(){
        
        if(txtPassword.text != "" && txtEmail.text != ""){
            btnAction.enabled = true
            btnAction.backgroundColor = UIColor.redColor()
        }
    }
    //-- Show and hidden keyboard 
    
    
    
    func ShowHiddenKeyboard(notification : NSNotification){
        
        if let userInfo  = notification.userInfo{
            
            let keyboardFrame = userInfo[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue()
            let changeInHeight = keyboardFrame!.height + 40
            let isKeyboardShowing = notification.name == UIKeyboardWillShowNotification
            
            if isKeyboardShowing{
                _srollview.contentInset.bottom = changeInHeight
                _srollview.scrollIndicatorInsets.bottom = changeInHeight
            }else{
                _srollview.contentInset.bottom = 0
                _srollview.scrollIndicatorInsets.bottom = 0
            }
            
            
            UIView.animateWithDuration(0, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.view.updateFocusIfNeeded()
                }, completion: { (completed) in
                    //==
                    if isKeyboardShowing{
                        
                    }
            })
           
        }
        
    }
    

    
    
    @IBAction func Btn_Action(sender: AnyObject) {
     
        btnOK()
       
    
    }
    
    func btnOK(){
        //--check 
        
        
        if let userTonTai = USER[txtEmail.text!]{
            
            if userTonTai == txtPassword.text {
                
                let detailVC = self.storyboard?.instantiateViewControllerWithIdentifier("DetailVC")
                self.navigationController?.pushViewController(detailVC!, animated: true)
                
            }else{
                
                AlertViewShow("", message: "Mat Khau Sai", bool: true)
            }
            
        }else{
            
         AlertViewShow("Thong Bao", message: "Tai Khoan Khong Ton Tai", bool: true)
        }
        
       
    }
    
    
    func AlertViewShow(title : String, message : String, bool : Bool){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
        let actionCancel =  UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let actionOk = UIAlertAction(title: "OK", style: .Default, handler: nil)
        actionCancel.setValue(UIColor.redColor(), forKey: "titleTextColor")
        
      
        
        //--
        
        //--
        if(bool){
            
            alertController.addAction(actionCancel)
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }else{
            
            
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            
         alertView.addTextFieldWithConfigurationHandler({ (textEmail) in
            
         })
            
         alertView.addTextFieldWithConfigurationHandler({ (textPass) in
           
         })
            alertView.addAction(actionCancel)
            alertView.addAction(actionOk)
           
          self.presentViewController(alertView, animated: true, completion: nil)
         
        }
        
        
        
        
    }
    
 
 
    @IBAction func ActionDangKi(sender: UIButton) {
        
        
        AlertViewShow("Form Dang Ki ", message: "nhap email vs pass ", bool: false)
        
    }
   
    
    
}
