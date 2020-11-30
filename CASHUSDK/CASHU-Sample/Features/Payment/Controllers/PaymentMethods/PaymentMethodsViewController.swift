//
//  PaymentMethodsViewController.swift
//  CASHU-Sample
//
//  Created by Ahmed Abd El-Samie on 6/6/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import Foundation
import UIKit

class PaymentMethodsViewController: UIViewController {
    
    @IBOutlet weak var paymentMethodsTableView: UITableView!
    var paymentMethodsList : [PaymentMethod] = []
    
    var product : Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paymentMethodsTableView.rowHeight = UITableView.automaticDimension
        paymentMethodsTableView.estimatedRowHeight = 96
        
        self.configureData()
        self.paymentMethodsTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Payment Method"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func configureData(){
        let paymentMethod = PaymentMethod()
        paymentMethod.name = "CASHU"
        paymentMethodsList.append(paymentMethod)
        let paymentMethod2 = PaymentMethod()
        paymentMethod2.name = "Other"
        paymentMethodsList.append(paymentMethod2)
        
        self.paymentMethodsTableView.reloadData()
    }
}

extension PaymentMethodsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentMethodsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentMethodsTableViewCell") as! PaymentMethodsTableViewCell
        
        let paymentMethod = self.paymentMethodsList[indexPath.row]
        cell.paymentMethodLabel.text = paymentMethod.name
        cell.paymentMethodImageView.image = UIImage(named: paymentMethod.name)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == 0){
            //******* Setup CASHU Configurations
            let cashuConfigurations : CASHUConfigurations = CASHUConfigurations()
            //The Merchant ID that you have received from CASHU
            cashuConfigurations.clientID = "CLIENT_ID_PROD-23B904EFA9F3F59AA03530B13D667E39"
            //MERCHANT REFERENCE SHOULD BE UNIQUE, THIS IS TOTALY USED BY YOU
            cashuConfigurations.merchantReference = "cu\(Date().timeIntervalSince1970)"
            cashuConfigurations.environment = .prod
            cashuConfigurations.delegate = self
            cashuConfigurations.cashuEnvironment = .uat
            // Initializing Product Details
            let productDetails : ProductDetails = ProductDetails()
            productDetails.currency = product?.currecy ?? .usd
            productDetails.productName = product?.name ?? ""
            productDetails.price = product?.decimalPrice ?? 0.0
            productDetails.productImage = UIImage(named: product?.name ?? "")
            productDetails.serviceName = "service_1"
            cashuConfigurations.productDetails = productDetails
 
            cashuConfigurations.presentingMethod = .push
            cashuConfigurations.language = .english
            cashuConfigurations.isLoggingEnabled = true
            //**************
            
            
            CASHUServices.initiateProductPaymentInParent(self, configurations: cashuConfigurations)
            
        }
    }
    
}

extension PaymentMethodsViewController : CASHUServicesDelegate{
    func didFinishPaymentSuccessfullyWithReferenceID(referenceID: String, productDetails: ProductDetails) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func didFailPaymentWithReferenceID(referenceID: String, productDetails: ProductDetails) {

    }
}
