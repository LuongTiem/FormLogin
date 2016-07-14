//
//  ViewController.swift
//  FormSign
//
//  Created by ReasonAmu on 7/13/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var img_background: UIImageView!
    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtPassWord: UITextField!
    
 
    @IBOutlet weak var contraintTopChildren: NSLayoutConstraint!
    @IBOutlet weak var viewChildren: UIView!
    @IBOutlet weak var btnSign: UIButton!
    @IBOutlet weak var btnShow: UIButton!
    var User = ["luongtiem": "123","tiem":"tiem"]
    var checkEmpty = true
    override func viewDidLoad() {
        super.viewDidLoad()
        txtUser.placeholder = "Enter User .... "
        txtPassWord.placeholder = "Enter Password .... "
        txtPassWord.secureTextEntry = true
        
        
        CustomTextFieldCode()
        hiddenButton()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.KeyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil);
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.KeyboardWillHidden), name:UIKeyboardWillHideNotification, object: nil);
        
    
    }
    override func viewWillLayoutSubviews() {
        
        
       
    }
    
    func ToadoPoint() -> CGFloat{
        
         let maxY = self.view.frame.maxY
        let  view2_Y = self.viewChildren.frame.maxY
        print(maxY - view2_Y)
        return  maxY - view2_Y
    }
  
    func showButton(){
        
        btnSign.enabled = true
        btnShow.enabled = true
        btnShow.backgroundColor = UIColor.redColor().colorWithAlphaComponent(0.8)
        btnSign.backgroundColor = UIColor.redColor().colorWithAlphaComponent(0.8)
    }
    
    func hiddenButton(){
        
        btnShow.enabled = false
        btnSign.enabled = false
        btnSign.backgroundColor = UIColor.clearColor()
        btnShow.backgroundColor = UIColor.clearColor()
        
    }
    
    
    
    func CustomTextFieldCode(){
        
       let img_User =  UIImageView(image: UIImage(named: "user"))
            img_User.frame = CGRectMake(0, 0, 30, 20) //-- width image + 1 khoang trang de cach bien trai ( x ) textfield
        txtUser.leftView = img_User
        txtUser.leftView!.contentMode = UIViewContentMode.ScaleAspectFit
        txtUser.leftViewMode = UITextFieldViewMode.Always
        
        let img_Pass = UIImageView(image: UIImage(named: "pass"))
            img_Pass.frame = CGRectMake(0, 0, 30, 20)
        
        txtPassWord.leftView = img_Pass
        txtPassWord.leftView!.contentMode = UIViewContentMode.ScaleAspectFit
        txtPassWord.leftViewMode = UITextFieldViewMode.Always
        
        
        
    }
    
    @IBAction func btn_Sign(sender: AnyObject) {
        
        if let UserTonTai = User[txtUser.text!] {
            
            UserTonTai ==  txtPassWord.text ? print("Dang nhap thanh cong") : print("Mat khau sai")
       
        }else{
            print("Tai khoan khong ton tai")
        }
    }
    
    
    @IBAction func btn_Show(sender: AnyObject) {
        
        for (user, pass) in User {
            print("User : \(user) \nPassword : \(pass)" )
        }
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if (txtUser == textField) {
            txtUser.leftViewMode = UITextFieldViewMode.Never
            let attributes = [NSUnderlineStyleAttributeName : NSUnderlineStyle.StyleSingle.rawValue as AnyObject]
            txtUser.attributedPlaceholder = NSAttributedString(string: "Enter User",
                                                                 attributes:attributes)
            return true
        }
        
        if( txtPassWord == txtPassWord){
            txtPassWord.leftViewMode = UITextFieldViewMode.Never
          let attributes2 = [NSUnderlineStyleAttributeName : NSUnderlineStyle.StyleSingle.rawValue as AnyObject]
            txtPassWord.attributedPlaceholder = NSAttributedString(string: "Enter Password",
                                                               attributes:attributes2)
            return true
        }
        
        
        return false
    }
    

    
    func textFieldDidEndEditing(textField: UITextField) {
        
        if(textField == txtUser){
            txtUser.leftViewMode = UITextFieldViewMode.Always
            
        }
        if(textField == txtPassWord) {
            
            txtPassWord.leftViewMode = UITextFieldViewMode.Always
            checkEmpty = !checkEmpty
        }
       
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if(textField == txtUser) {
            txtPassWord.becomeFirstResponder()
            txtUser.leftViewMode = UITextFieldViewMode.Always
        }
        
        if(txtPassWord == textField){
            txtPassWord.leftViewMode = UITextFieldViewMode.Always
           
        }
    
        
        return false
    }
    
    
  
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {

        if(textField == txtPassWord && txtUser.text != "" && string != ""){
            
            showButton()
            
        }

        
        
     
        self.updateFocusIfNeeded()
        
        return true
    }
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
       
        self.view.endEditing(true)

        
       
    }
    
    func checkValueStringEmpty(){
        
        if(txtPassWord.text != "" && txtUser.text != ""){
            
            showButton()
            
        }
        
    }

    
    
    @IBAction func btnAdd(sender: UIButton) {
        let getUser = txtUser.text
        let getPass = txtPassWord.text
        
        if(getPass != "" && getUser != ""){
             //-- add dictionary
            User[getUser!] = getPass
            
        }else{
            
            print("2 truong k dc de trong")
        }
        showButton()
        
    }
    
    @IBAction func btnEdit(sender: AnyObject) {
        
        if let UserTontaiK = User[txtUser.text!]{
            
            User[UserTontaiK] =  txtPassWord.text
        }else{
            print("Tai khoan k ton tai")
        }
     
        
        
    }
    
    
    @IBAction func btnDelete(sender: UIButton) {
        
        if let UserTonTai = User[txtUser.text!] {
            

            
                User.removeValueForKey(UserTonTai)
               print("xoa thanh cong")

            
        }else{
             print("Tai khoan k ton tai  ")
        }
        ShowAlertView()
        showButton()
    }
    
    
    func ShowAlertView(){
        
        let alertview = UIAlertController(title: "Title", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
        alertview.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alertview, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    
 
    func KeyboardWillShow (notification : NSNotification){
        
        var info = notification.userInfo!
        let keyboardFrame = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
         let height = keyboardFrame.size.height
        
        
        print("chieu cao frame keyboard \(height)")
    }
    

    
    
    func KeyboardWillHidden(){
        
        
    }
    
}

