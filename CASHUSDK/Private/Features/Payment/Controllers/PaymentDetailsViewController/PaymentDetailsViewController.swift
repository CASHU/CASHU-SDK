//
//  PaymentDetailsViewController.swift
//  CASHU
//
//  Created by Ahmed Abd El-Samie on 6/19/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation
import UIKit

class PaymentDetailsViewController: UIViewController , UITableViewDataSource  , UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PaymentDetails.feesModelList.count  
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FessTableViewCell", for: indexPath) as! FessTableViewCell
        
        if (LocalizationManager.sharedInstance.getCurrentLanguage() == .arabic){
            cell.nameFees.text = PaymentDetails.feesModelList[indexPath.row].nameAr
        }else {
            cell.nameFees.text  = PaymentDetails.feesModelList[indexPath.row].nameEn
        }
        
        cell.valueFees.text = (PaymentDetails.feesModelList[indexPath.row].value ?? "") + " " + (UserIdentificationDataCenter.sharedInstance().accountInfo?.balanceCurrency ?? "")
        
        
        return cell
        
    }
    
    
    @IBOutlet weak var feesLabel: UILabel!
    @IBOutlet weak var feesTV: UITableView!
    
    
    
    
    
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var scrollViewContentView : UIView!
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var subtitleLabel : UILabel!
    
    @IBOutlet weak var walletTitleLabel : UILabel!
    @IBOutlet weak var walletBalanceLabel : UILabel!
    @IBOutlet weak var walletBalanceWarningImage : UIImageView!
    @IBOutlet weak var walletBalanceWarningLabel : UILabel!
    @IBOutlet weak var walletBalanceWarningDetailsContainerView : UIView!
    @IBOutlet weak var walletBalanceWarningDetailsLabel : UILabel!
    @IBOutlet weak var walletBalanceContainerView : UIView!
    
    @IBOutlet weak var transactionTitleLabel : UILabel!
    
    @IBOutlet weak var productInfoContainerView : UIView!
    @IBOutlet weak var productNameLabel : UILabel!
    @IBOutlet weak var productImage : UIImageView!
    @IBOutlet weak var productPriceLabel : UILabel!
    @IBOutlet weak var merchantNameTitleLabel : UILabel!
    @IBOutlet weak var merchantNameValueLabel : UILabel!
    
    @IBOutlet weak var actionButton : UIButton!
    
    @IBOutlet weak var totalPaymentContainerView : UIView!
    @IBOutlet weak var totalPaymentLabel : UILabel!
    @IBOutlet weak var totalPaymentCostLabel : UILabel!
    @IBOutlet weak var totalPaymentCostActivityIndicator : UIActivityIndicatorView!

    private var didLayoutSubViews = false
    private var isBalanceSuffiecent = true    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        
        self.actionButton.alpha = 0.75
        self.actionButton.isEnabled = false
        
        PaymentDataCenter.sharedInstance().getPaymentDetailsWithDelegate(self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if(!self.didLayoutSubViews){
            ThreadsUtility.execute({
                self.self.setupActionButtons()
            }, afterDelay: 0.1)
            self.didLayoutSubViews = true
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func setupView(){
        self.setupText()
        self.setupViewOrintationBasedOnLocalization()
        self.setupActionButtonText()
    }
    
    
    func setupText(){
        self.titleLabel.text = LocalizationManager.sharedInstance.getTranslationForKey("PaymentTitle")
        self.feesLabel.text = LocalizationManager.sharedInstance.getTranslationForKey("FeesTitle")
        self.subtitleLabel.text = LocalizationManager.sharedInstance.getTranslationForKey("PaymentSubtitle")! + " " + (UserIdentificationDataCenter.sharedInstance().accountInfo?.name ?? "")
        
        self.walletTitleLabel.text = LocalizationManager.sharedInstance.getTranslationForKey("WalletTitle")
        self.walletBalanceLabel.text = (UserIdentificationDataCenter.sharedInstance().accountInfo?.balanceAmount ?? "") + " " + (UserIdentificationDataCenter.sharedInstance().accountInfo?.balanceCurrency ?? "")
        
        self.walletBalanceWarningLabel.text = isBalanceSuffiecent ? "" :  LocalizationManager.sharedInstance.getTranslationForKey("InsuffecientBalance")
        
        
        self.walletBalanceWarningDetailsLabel.text = isBalanceSuffiecent ? "" :   LocalizationManager.sharedInstance.getTranslationForKey("WalletFund")
        
        self.transactionTitleLabel.text = LocalizationManager.sharedInstance.getTranslationForKey("TransactionDetails")
        self.merchantNameTitleLabel.text = LocalizationManager.sharedInstance.getTranslationForKey("Merchant")
        self.merchantNameValueLabel.text = UserIdentificationDataCenter.sharedInstance().merchantDetails?.merchantName
        
        self.productNameLabel.text = (UserIdentificationDataCenter.sharedInstance().paymentDetails?.displayText ?? "")
        self.productImage.image = CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.productDetails.productImage
        self.productPriceLabel.text = (UserIdentificationDataCenter.sharedInstance().paymentDetails?.amount ?? "") + " " + (UserIdentificationDataCenter.sharedInstance().paymentDetails?.currency ?? "")
        self.totalPaymentLabel.text = LocalizationManager.sharedInstance.getTranslationForKey("TotalAmount")
        self.totalPaymentCostLabel.text = (UserIdentificationDataCenter.sharedInstance().paymentDetails?.amount ?? "") + " " + (UserIdentificationDataCenter.sharedInstance().paymentDetails?.currency ?? "")
        
        
        if(isBalanceSuffiecent){
            self.walletBalanceWarningImage.isHidden = true
            self.walletBalanceWarningDetailsContainerView.isHidden = true
            
            self.totalPaymentContainerView.isHidden = false
            self.walletBalanceLabel.textColor = .black
            self.productInfoContainerView.alpha = 1
        }else{
            self.walletBalanceWarningImage.isHidden = false
            self.walletBalanceWarningDetailsContainerView.isHidden = false
            
            self.totalPaymentContainerView.isHidden = true
            self.walletBalanceLabel.textColor = .red
            self.walletBalanceWarningLabel.textColor = .red
            self.productInfoContainerView.alpha = 0.75
        }
        
    }
    
    func setupActionButtons(){
        
        self.setupActionButtonText()
        
        UIUtilities.createCircularViewforView(actionButton, withRadius: 6)
        UIUtilities.dropShadowForView(actionButton, withShadowColor: .black, andShadowOpacity: 0.3, andMaskToBounds: false)
    }
    
    func setupActionButtonText(){
        if(isBalanceSuffiecent){
            actionButton.setTitle(LocalizationManager.sharedInstance.getTranslationForKey("PayNow"), for: .normal)
        }else{
            actionButton.setTitle(LocalizationManager.sharedInstance.getTranslationForKey("ReturnTo")! + " " + (UserIdentificationDataCenter.sharedInstance().merchantDetails?.merchantName ?? ""), for: .normal)
            self.actionButton.backgroundColor = ColorsUtility.colorWithHexString("#1DAFEC")
        }
    }
    
    func setupViewOrintationBasedOnLocalization(){
        if(LocalizationManager.sharedInstance.getCurrentLanguage() == .arabic){
            self.scrollViewContentView.semanticContentAttribute = .forceRightToLeft
            self.walletBalanceContainerView.semanticContentAttribute = .forceRightToLeft
            self.productInfoContainerView.semanticContentAttribute = .forceRightToLeft
            self.totalPaymentContainerView.semanticContentAttribute = .forceRightToLeft
            
            self.walletBalanceWarningDetailsLabel.textAlignment = .right
            self.productNameLabel.textAlignment = .right
            self.merchantNameValueLabel.textAlignment = .right
        }
    }
    
    
    @IBAction func doAction(_ sender: UIButton) {
        if(isBalanceSuffiecent){
            PaymentDataCenter.sharedInstance().doPaymentWithDelegate(self)
        }else{
            self.back(UIButton())
        }
    }
    
    @IBAction func showInfo(_ sender: UIButton) {
        PopupViewController.showPopupInController(self, title: LocalizationManager.sharedInstance.getTranslationForKey("CashPayments")!, message: LocalizationManager.sharedInstance.getTranslationForKey("CashPaymentsInfo")!, leftButtonTitle: LocalizationManager.sharedInstance.getTranslationForKey("Ok")!, rightButtonTitle: nil)
    }
    
    @IBAction func back(_ sender: UIButton) {
        UserIdentificationDataCenter.sharedInstance().cancelInitializationWithDelegate(self)
    }
}

extension PaymentDetailsViewController : OperationDelegate{
    
    func didFinishOperation(_ operationID: OperationID) {
        
    }
    
    func didFinishOperation(_ operationID: OperationID, object: AnyObject) {
        if(operationID == .CompletePayment){
            if let cashuResponse = object as? CASHUResponse {
                if(cashuResponse.cashuBodyResponse.resultCode != "200"){
                    var message = ""
                    switch CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.language{
                    case .arabic:
                        message = cashuResponse.cashuBodyResponse.resultMessageAr
                    case.english:
                        message = cashuResponse.cashuBodyResponse.resultMessageEn
                    }
                    
                    PopupViewController.showPopupInController(self, title: LocalizationManager.sharedInstance.getTranslationForKey("Error")!, message: message, leftButtonTitle: LocalizationManager.sharedInstance.getTranslationForKey("Ok")!, rightButtonTitle: nil)
                    
                    if CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.isLoggingEnabled {
                        NSLog("***!!!*** CASHU Error : ***!!!*** \n\(cashuResponse.cashuBodyResponse.resultMessageError)")
                    }
                }else{
                    self.performSegue(withIdentifier: "goToSuccessPage", sender: nil)
                }
            }
        }else if(operationID == .CancelInitialize){
            if(CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.presentingMethod == .push){
                var found = false
                for viewController in (self.navigationController?.viewControllers.reversed())! {
                    if(viewController is InitializationViewController){
                        found = true
                        continue
                    }
                    
                    if(found){
                        viewController.modalPresentationStyle = .fullScreen

                        self.navigationController?.isNavigationBarHidden = false
                        self.navigationController?.popToViewController(viewController, animated: true)
                    }
                }
            }else if(CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.presentingMethod == .present){
                self.dismissAnimated()
            }
            
            CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.delegate?.didFailPaymentWithReferenceID(referenceID: CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.merchantReference, productDetails: CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.productDetails)
        }else if(operationID == .PaymentDetails){
            if let cashuResponse = object as? CASHUResponse {
                if(cashuResponse.cashuBodyResponse.resultCode == "200"){
                    let balanceAmount = Double(UserIdentificationDataCenter.sharedInstance().accountInfo?.balanceAmount ?? "0") ?? 0.0
                    let productAmount = Double(PaymentDataCenter.sharedInstance().finalPaymentDetails?.convertedAmount ?? "0") ?? 0.0
                    if(balanceAmount < productAmount){
                        isBalanceSuffiecent = false
                    }
                    
                    self.setupView()
                    
                    self.actionButton.alpha = 1
                    self.actionButton.isEnabled = true
                    
                    self.totalPaymentCostActivityIndicator.stopAnimating()
                    self.totalPaymentCostLabel.isHidden = false
                    self.totalPaymentCostLabel.text = (PaymentDataCenter.sharedInstance().finalPaymentDetails?.convertedAmount ?? "") + " " + (PaymentDataCenter.sharedInstance().finalPaymentDetails?.convertedCurrency ?? "")
                    
                    self.feesTV.reloadData()
                    self.totalPaymentCostLabel.text = PaymentDetails.totalAmount + " " + (PaymentDataCenter.sharedInstance().finalPaymentDetails?.convertedCurrency ?? "")
                }else {
                    var message = ""
                    switch CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.language{
                    case .arabic:
                        message = cashuResponse.cashuBodyResponse.resultMessageAr
                    case.english:
                        message = cashuResponse.cashuBodyResponse.resultMessageEn
                    }
                    
                    PopupViewController.showPopupInController(self, title: LocalizationManager.sharedInstance.getTranslationForKey("Error")!, message: message, leftButtonTitle: LocalizationManager.sharedInstance.getTranslationForKey("Ok")!, rightButtonTitle: nil)
                    
                    if CASHUConfigurationsCenter.sharedInstance().cashuConfigurations.isLoggingEnabled {
                        NSLog("***!!!*** CASHU Error : ***!!!*** \n\(cashuResponse.cashuBodyResponse.resultMessageError)")
                    }
                }
            }
        }
    }
    
    func didRecieveErrorForOperation(_ operationID: OperationID, andWithError error: Error?) {
        
    }
    
    func didCancelOperation(_ operationID: OperationID) {
        
    }
}
