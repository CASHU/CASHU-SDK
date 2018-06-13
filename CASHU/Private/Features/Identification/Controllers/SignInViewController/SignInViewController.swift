//
//  SignInViewController.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/6/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation
import UIKit

class SignInViewController: UIViewController {
    
//    @IBOutlet weak var scrollView : UIScrollView!
//    @IBOutlet weak var scrollViewContentView : UIView!
//
//    @IBOutlet weak var welcomeLabel : UILabel!
//    @IBOutlet weak var phoneNumberLabel : UILabel!
//    @IBOutlet weak var phoneNumberCodeLabel : UILabel!
//    @IBOutlet weak var phoneNumberTextField : UITextField!
//    @IBOutlet weak var phoneNumberTextFieldHeightConstraint : NSLayoutConstraint!
//    @IBOutlet weak var passwordLabel : UILabel!
//    @IBOutlet weak var passwordTextField : UITextField!
//    @IBOutlet weak var passwordTextFieldHeightConstraint : NSLayoutConstraint!
//    @IBOutlet weak var passwordVisibilityButton : UIButton!
//    @IBOutlet weak var passwordVisibilityTopConstraint : NSLayoutConstraint!
//    @IBOutlet weak var loginButton : UIButton!
//    @IBOutlet weak var forgotPasswordButton : UIButton!
//
//    @IBOutlet weak var keypadHandleViewHeightConstraint : NSLayoutConstraint!
//
//    private var didLayoutSubViews = false
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.setupTextFields()
//        self.setupText()
//        self.setupActionButtons()
//        self.setupViewOrintationBasedOnLocalization()
//        self.setupKeypadListeners()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.isNavigationBarHidden = true
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        self.dismissKeypad()
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        if(!self.didLayoutSubViews){
//            ThreadsUtility.execute({
//                self.setupBottomBordersForTextFields()
//            }, afterDelay: 0.1)
//            self.didLayoutSubViews = true
//        }
//    }
//
//    override var preferredStatusBarStyle: UIStatusBarStyle{
//        return .default
//    }
//
//    func setupBottomBordersForTextFields(){
//        let borderColor = ColorsUtility.colorWithHexString("#c6cbd4")
//
//        phoneNumberTextField.setBottomBorderWithColor(borderColor)
//        phoneNumberTextField.heightConstraint = phoneNumberTextFieldHeightConstraint
//        passwordTextField.setBottomBorderWithColor(borderColor)
//        passwordTextField.heightConstraint = passwordTextFieldHeightConstraint
//    }
//
//    func setupTextFields(){
//
//        if(LocalizationManager.sharedInstance.getCurrentLanguage() != .english){
//            phoneNumberTextField.textAlignment = .right
//            passwordTextField.textAlignment = .right
//        }
//
//        phoneNumberTextField.placeholder = LocalizationManager.sharedInstance.getTranslationForKey("EnterYourPhoneNumber")
//        passwordTextField.placeholder = LocalizationManager.sharedInstance.getTranslationForKey("EnterYourPassword")
//
//        UIUtilities.changePlaceHolderTextColorForTextField(phoneNumberTextField, color: ColorsUtility.colorWithHexString("#c6cbd4"))
//        UIUtilities.changePlaceHolderTextColorForTextField(passwordTextField, color: ColorsUtility.colorWithHexString("#c6cbd4"))
//
//        if(LocalizationManager.sharedInstance.getCurrentLanguage() != .english){
//            UIUtilities.setPaddingToTextField(self.passwordTextField, withFrame: CGRect(x: 0, y: 0, width: 35, height: 35))
//            passwordVisibilityTopConstraint.constant = 5
//        }else{
//            UIUtilities.setRightPaddingToTextField(self.passwordTextField, withFrame: CGRect(x: 0, y: 0, width: 35, height: 35))
//        }
//    }
//
//    func setupText(){
//        self.welcomeLabel.text = LocalizationManager.sharedInstance.getTranslationForKey("Login")
//        self.phoneNumberLabel.text = LocalizationManager.sharedInstance.getTranslationForKey("PhoneNumber")
//        self.passwordLabel.text = LocalizationManager.sharedInstance.getTranslationForKey("Password")
//        self.phoneNumberCodeLabel.text = LocalizationManager.sharedInstance.getTranslationForKey("CountryCode")
//        self.phoneNumberCodeLabel.alpha = 0.3
//    }
//
//    func setupActionButtons(){
//        loginButton.setTitle(LocalizationManager.sharedInstance.getTranslationForKey("Login"), for: .normal)
//        forgotPasswordButton.setTitle(LocalizationManager.sharedInstance.getTranslationForKey("ForgotYourPassword"), for: .normal)
//        UIUtilities.createCircularViewforView(loginButton, withRadius: 6)
//    }
//
//    func setupViewOrintationBasedOnLocalization(){
//        if(LocalizationManager.sharedInstance.getCurrentLanguage() == .arabic || LocalizationManager.sharedInstance.getCurrentLanguage() == .urdu){
//            self.scrollViewContentView.semanticContentAttribute = .forceRightToLeft
//        }
//    }
//
//    func setupKeypadListeners(){
//        UIUtilities.notifyMeWhenKeyPadWillShow(target: self, selector: #selector(updateViewScroll))
//        UIUtilities.notifyMeWhenKeyPadDidChangeFrame(target: self, selector: #selector(updateViewScroll))
//        UIUtilities.notifyMeWhenKeyPadWillHide(target: self, selector: #selector(updateViewScroll))
//
//        UIUtilities.addTapGestureToView(self.view, withTarget: self, andSelector: #selector(dismissKeypad), andCanCancelTouchesInTheView: false)
//    }
//
//    @objc func dismissKeypad(){
//        self.phoneNumberTextField.resignFirstResponder()
//        self.passwordTextField.resignFirstResponder()
//    }
//
//    @objc func updateViewScroll(notification: NSNotification){
//        let userInfo = notification.userInfo!
//
//        let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
//        let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
//        let convertedKeyboardEndFrame = view.convert(keyboardEndFrame, from: view.window)
//        keypadHandleViewHeightConstraint.constant = (view.bounds.maxY - (convertedKeyboardEndFrame.minY))
//        AnimationsUtility.animateLayoutFor(self.view, duration: Float(animationDuration), delay: 0.0, completionBlock: nil)
//    }
//
//    func isLoginFormValid() -> Bool{
//        var isError = false
//        if(self.phoneNumberCodeLabel.text == LocalizationManager.sharedInstance.getTranslationForKey("CountryCode")){
//            self.phoneNumberTextField.showErrorMessage(LocalizationManager.sharedInstance.getTranslationForKey("CountryCodeIsRequired")!)
//            isError = true
//        }else if(!ValidationsUtility.isStringNotEmpty(self.phoneNumberTextField.text!)){
//            self.phoneNumberTextField.showErrorMessage(LocalizationManager.sharedInstance.getTranslationForKey("PhoneNumberIsRequired")!)
//            isError = true
//        }
//
//        if(!ValidationsUtility.isStringNotEmpty(self.passwordTextField.text!)){
//            self.passwordTextField.showErrorMessage(LocalizationManager.sharedInstance.getTranslationForKey("PasswordIsRequired")!)
//            isError = true
//        }
//
//        return !isError
//    }
//
//    func hideAllErrorMessages(){
//        self.phoneNumberTextField.hideErrorMessage()
//        self.passwordTextField.hideErrorMessage()
//    }
//
//    @IBAction func signIn(_ sender: UIButton) {
//        self.hideAllErrorMessages()
//        if(self.isLoginFormValid()){
//            self.dismissKeypad()
//            let loginQuery = LoginQuery()
//            loginQuery.phoneNumber = self.phoneNumberCodeLabel.text! + self.phoneNumberTextField.text!
//            loginQuery.password = self.passwordTextField.text!
//            UserIdentificationDataCenter.sharedInstance().signInWithDelegate(self, loginQuery: loginQuery)
//        }
//    }
//
//    @IBAction func showCountryCodeSelector(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: "GeneralStoryboard", bundle: nil)
//        let countryList = storyboard.instantiateViewController(withIdentifier: "CountryList") as! CountryList
//        countryList.delegate = self
//        self.navigationController?.pushViewController(countryList, animated: true)
//    }
//
//    @IBAction func togglePasswordVisiblity(_ sender: UIButton) {
//        if(self.passwordTextField.isSecureTextEntry){
//            passwordVisibilityButton.setImage(#imageLiteral(resourceName: "blackPasswordNotVisible"), for: .normal)
//        }else{
//            passwordVisibilityButton.setImage(#imageLiteral(resourceName: "blackPasswordVisible"), for: .normal)
//        }
//
//        self.passwordTextField.isSecureTextEntry = !self.passwordTextField.isSecureTextEntry
//    }
//
//    @IBAction func back(_ sender: UIButton) {
//        self.navigationController?.popViewController(animated: true)
//    }
//}
//
//extension SignInViewController : UITextFieldDelegate{
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.signIn(UIButton())
//        return true
//    }
//}
//
//extension SignInViewController : CountryListDelegate{
//    func selectedCountry(country: Country) {
//        phoneNumberCodeLabel.alpha = 1.0
//        phoneNumberCodeLabel.text = "+\(country.phoneExtension)"
//    }
//}
//
//extension SignInViewController : OperationDelegate{
//
//    func didFinishOperation(_ operationID: OperationID) {
//
//    }
//
//    func didFinishOperation(_ operationID: OperationID, object: AnyObject) {
//        if(operationID == .SignIn){
//            if let isLoggedIn = object as? Bool {
//                if(isLoggedIn){
//                    ThreadsUtility.execute({
//                        UserIdentificationDataCenter.sharedInstance().updateDeviceTokenWithDelegate(nil, deviceToken: Messaging.messaging().fcmToken!)
//                        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
//                        (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = storyboard.instantiateInitialViewController()
//                    }, afterDelay: 0.0)
//                }else{
//                    PopupViewController.showPopupInController(self, title: "", message: LocalizationManager.sharedInstance.getTranslationForKey("WrongPhoneOrPassword")!, leftButtonTitle: LocalizationManager.sharedInstance.getTranslationForKey("Ok")!, rightButtonTitle: nil)
//                }
//            }
//        }
//    }
//
//    func didRecieveErrorForOperation(_ operationID: OperationID, andWithError error: Error?) {
//
//    }
//
//    func didCancelOperation(_ operationID: OperationID) {
//
//    }
}
