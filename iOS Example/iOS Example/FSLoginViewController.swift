
//
//  FSLoginViewController.swift
//  iOS Example
//
//  Created by Adel on 20/01/2020.
//  Copyright © 2020 FlagShip. All rights reserved.
//

import UIKit

/// Import Lib
import Flagship

class FSLoginViewController: UIViewController, UITextFieldDelegate {
    
    /// Login
    @IBOutlet var loginTextField:UITextField!
    /// Password
    @IBOutlet var passwordTestField:UITextField!
    /// Login btn
    @IBOutlet var loginBtn:UIButton!
    /// fb button
    @IBOutlet var faceBookBtn:UIButton!
    
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        //Round button login
        loginBtn.layer.cornerRadius = loginBtn.frame.height/2
        loginBtn.layer.masksToBounds = true
        
        faceBookBtn.layer.cornerRadius = loginBtn.frame.height/2
        faceBookBtn.layer.masksToBounds = true
        
        // Add gesture
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard)))
        
    }
    
    

    
    
    
    // Hide KeyBoard
    @objc func hideKeyBoard(){
        
        loginTextField.resignFirstResponder()
        passwordTestField.resignFirstResponder()
    }
    
    
 /// On Click Login
  @IBAction func onClickLogin(){
      
    /// Set Context
    Flagship.sharedInstance.updateContext("isVip", true)
    
    /// Start Flagship
    Flagship.sharedInstance.start(environmentId: "bkk9glocmjcg0vtmdlng", loginTextField.text, .BUCKETING) { (result) in
          
          
        /// When the sdk is ready ...
        if result == .Ready{
            
            DispatchQueue.main.async {
                 
                 self.performSegue(withIdentifier: "onClickLogin", sender: nil)
                 
             }
              
          }else{
              /// Manage Error
          }
      }
  }
    
    
    
    @IBAction func onCancel(){
        
        self.dismiss(animated: true, completion:nil)
        
        
    }
    
    
    // Delegate textField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            
            if updatedText.count > 3{
                
                loginBtn.isEnabled = true
            }else{
                
                loginBtn.isEnabled = false
            }
        }
        
        return true
    }
    
}
