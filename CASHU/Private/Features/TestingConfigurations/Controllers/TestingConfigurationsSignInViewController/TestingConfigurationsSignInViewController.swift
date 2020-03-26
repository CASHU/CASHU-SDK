//
//  TestingConfigurationsSignInViewController.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/25/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation
import UIKit

class TestingConfigurationsSignInViewController: UIViewController {
    
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var scrollViewContentView : UIView!
    
    @IBOutlet weak var emailAddressTitle : UILabel!
    @IBOutlet weak var emailAddressTextField : UITextField!
    @IBOutlet weak var emailAddressTextFieldHeightConstraint : NSLayoutConstraint!
    @IBOutlet weak var passwordTitle : UILabel!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var passwordTextFieldHeightConstraint : NSLayoutConstraint!
    @IBOutlet weak var loginButton : UIButton!
    
    @IBOutlet weak var keypadHandleViewHeightConstraint : NSLayoutConstraint!
    
    private var didLayoutSubViews = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextFields()
        self.setupKeypadListeners()
        
        if(BackEndConfigurations.isQuickTestingEnabled()){
            self.emailAddressTextField.text = "asmaa_cu"
            self.passwordTextField.text = "As21151566@"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.dismissKeypad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if(!self.didLayoutSubViews){
            ThreadsUtility.execute({
                self.setupBottomBordersForTextFields()
                self.self.setupActionButtons()
            }, afterDelay: 0.1)
            self.didLayoutSubViews = true
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func setupBottomBordersForTextFields(){
        let borderColor = ColorsUtility.colorWithHexString("#127CAE")
        
        emailAddressTextField.setBottomBorderWithColor(borderColor)
        emailAddressTextField.heightConstraint = emailAddressTextFieldHeightConstraint
        passwordTextField.setBottomBorderWithColor(borderColor)
        passwordTextField.heightConstraint = passwordTextFieldHeightConstraint
    }
    
    func setupTextFields(){        
        UIUtilities.changePlaceHolderTextColorForTextField(emailAddressTextField, color: ColorsUtility.colorWithHexString("#c6cbd4"))
        UIUtilities.changePlaceHolderTextColorForTextField(passwordTextField, color: ColorsUtility.colorWithHexString("#c6cbd4"))
    }
    
    func setupActionButtons(){
        UIUtilities.createCircularViewforView(loginButton, withRadius: 6)
        UIUtilities.dropShadowForView(loginButton, withShadowColor: .black, andShadowOpacity: 0.3, andMaskToBounds: false)
    }
    
    func setupKeypadListeners(){
        UIUtilities.notifyMeWhenKeyPadWillShow(target: self, selector: #selector(updateViewScroll))
        UIUtilities.notifyMeWhenKeyPadDidChangeFrame(target: self, selector: #selector(updateViewScroll))
        UIUtilities.notifyMeWhenKeyPadWillHide(target: self, selector: #selector(updateViewScroll))
        
        UIUtilities.addTapGestureToView(self.view, withTarget: self, andSelector: #selector(dismissKeypad), andCanCancelTouchesInTheView: false)
    }
    
    @objc func dismissKeypad(){
        self.emailAddressTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    @objc func updateViewScroll(notification: NSNotification){
        let userInfo = notification.userInfo!
        
        let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let convertedKeyboardEndFrame = view.convert(keyboardEndFrame, from: view.window)
        keypadHandleViewHeightConstraint.constant = (view.bounds.maxY - (convertedKeyboardEndFrame.minY))
        AnimationsUtility.animateLayoutFor(self.view, duration: Float(animationDuration), delay: 0.0, completionBlock: nil)
    }
    
    func isLoginFormValid() -> Bool{
        var isError = false
        if(!ValidationsUtility.isStringNotEmpty(self.emailAddressTextField.text!)){
            self.emailAddressTextField.showErrorMessage("Username is required")
            isError = true
        }
        
        if(!ValidationsUtility.isStringNotEmpty(self.passwordTextField.text!)){
            self.passwordTextField.showErrorMessage("Password is required")
            isError = true
        }
        
        return !isError
    }
    
    func hideAllErrorMessages(){
        self.emailAddressTextField.hideErrorMessage()
        self.passwordTextField.hideErrorMessage()
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        self.hideAllErrorMessages()
        if(self.isLoginFormValid()){
            self.dismissKeypad()
            if(self.emailAddressTextField.text == "asmaa_cu" && self.passwordTextField.text == "As21151566@"){
                self.performSegue(withIdentifier: "showConfigurationsPage", sender: nil)
            }else{
                self.emailAddressTextField.showErrorMessage("Username is wrong")
                self.passwordTextField.showErrorMessage("Password is wrong")
            }
        }
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.dismissAnimated()
    }
}

extension TestingConfigurationsSignInViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.signIn(UIButton())
        return true
    }
}
