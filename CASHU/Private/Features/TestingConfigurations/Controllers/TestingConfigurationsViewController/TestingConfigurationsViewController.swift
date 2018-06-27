//
//  TestingConfigurationsViewController.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/25/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation
import UIKit

class TestingConfigurationsViewController: UIViewController {
    
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var scrollViewContentView : UIView!
    
    @IBOutlet weak var clientIDTextField : UITextField!
    @IBOutlet weak var clientIDTextFieldHeightConstraint : NSLayoutConstraint!
    @IBOutlet weak var languageSwitch : UISwitch!
    @IBOutlet weak var cashuEnvSwitch : UISwitch!
    @IBOutlet weak var envSwtich : UISwitch!
    @IBOutlet weak var changeButton : UIButton!
    
    @IBOutlet weak var keypadHandleViewHeightConstraint : NSLayoutConstraint!
    
    private var didLayoutSubViews = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextFields()
        self.setupKeypadListeners()
        self.setupSwitches()
        self.setupData()
        
        if(BackEndConfigurations.isQuickTestingEnabled()){
            self.clientIDTextField.text = "CLIENT_ID_PROD-23B904EFA9F3F59AA03530B13D667E39"
            self.envSwtich.isOn = false
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
        
        clientIDTextField.setBottomBorderWithColor(borderColor)
        clientIDTextField.heightConstraint = clientIDTextFieldHeightConstraint
    }
    
    func setupTextFields(){
        UIUtilities.changePlaceHolderTextColorForTextField(clientIDTextField, color: ColorsUtility.colorWithHexString("#c6cbd4"))
    }
    
    func setupActionButtons(){
        UIUtilities.createCircularViewforView(changeButton, withRadius: 6)
        UIUtilities.dropShadowForView(changeButton, withShadowColor: .black, andShadowOpacity: 0.3, andMaskToBounds: false)
    }
    
    func setupSwitches(){
        languageSwitch.layer.cornerRadius = 15
        languageSwitch.layer.borderWidth = 2
        languageSwitch.layer.borderColor = UIColor.gray.cgColor

        cashuEnvSwitch.layer.cornerRadius = 15
        cashuEnvSwitch.layer.borderWidth = 2
        cashuEnvSwitch.layer.borderColor = UIColor.gray.cgColor
        
        envSwtich.layer.cornerRadius = 15
        envSwtich.layer.borderWidth = 2
        envSwtich.layer.borderColor = UIColor.gray.cgColor
    }
    
    func setupData(){
        if let cashuConfigurations = CASHUConfigurationsCenter.sharedInstance().cashuTestingConfigurations{
            self.clientIDTextField.text = cashuConfigurations.clientID
            envSwtich.isOn = cashuConfigurations.environment == .dev ? true : false
            languageSwitch.isOn = cashuConfigurations.language == .english ? true : false
            cashuEnvSwitch.isOn = cashuConfigurations.cashuEnvironment == .uat ? true : false
        }
    }
    
    func setupKeypadListeners(){
        UIUtilities.notifyMeWhenKeyPadWillShow(target: self, selector: #selector(updateViewScroll))
        UIUtilities.notifyMeWhenKeyPadDidChangeFrame(target: self, selector: #selector(updateViewScroll))
        UIUtilities.notifyMeWhenKeyPadWillHide(target: self, selector: #selector(updateViewScroll))
        
        UIUtilities.addTapGestureToView(self.view, withTarget: self, andSelector: #selector(dismissKeypad), andCanCancelTouchesInTheView: false)
    }
    
    @objc func dismissKeypad(){
        self.clientIDTextField.resignFirstResponder()
    }
    
    @objc func updateViewScroll(notification: NSNotification){
        let userInfo = notification.userInfo!
        
        let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let convertedKeyboardEndFrame = view.convert(keyboardEndFrame, from: view.window)
        keypadHandleViewHeightConstraint.constant = (view.bounds.maxY - (convertedKeyboardEndFrame.minY))
        AnimationsUtility.animateLayoutFor(self.view, duration: Float(animationDuration), delay: 0.0, completionBlock: nil)
    }
    
    func isFormValid() -> Bool{
        var isError = false
        if(!ValidationsUtility.isStringNotEmpty(self.clientIDTextField.text!)){
            self.clientIDTextField.showErrorMessage("Client ID is required")
            isError = true
        }
        
        return !isError
    }
    
    func hideAllErrorMessages(){
        self.clientIDTextField.hideErrorMessage()
    }
    
    @IBAction func changeConfigurations(_ sender: UIButton) {
        self.hideAllErrorMessages()
        if(self.isFormValid()){
            self.dismissKeypad()
            
            let cashuConfigurations : CASHUConfigurations = CASHUConfigurations()
            cashuConfigurations.clientID = self.clientIDTextField.text ?? ""
            cashuConfigurations.environment = envSwtich.isOn ? .dev : .prod
            cashuConfigurations.language = languageSwitch.isOn ? .english : .arabic
            cashuConfigurations.cashuEnvironment = cashuEnvSwitch.isOn ? .uat : .prod
            
            CASHUConfigurationsCenter.sharedInstance().setCASHUTestingConfigurations(testingConfigurations:  cashuConfigurations)
            
            self.dismissAnimated()
        }
    }
}
