//
//  ProductsListViewController.swift
//  CASHU-Sample
//
//  Created by Ahmed Abd El-Samie on 6/6/18.
//  Copyright © 2018 CASHU. All rights reserved.
//

import UIKit

class ProductsListViewController: UIViewController {
    
    @IBOutlet weak var productsTableView: UITableView!
    var productList : [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configurationsButton = UIBarButtonItem(image: UIImage(named: "config"), style: .plain, target: self, action: #selector(self.openConfigurations(_:)))
        navigationItem.rightBarButtonItem = configurationsButton
        
        productsTableView.rowHeight = UITableView.automaticDimension
        productsTableView.estimatedRowHeight = 96
        
        self.configureData()
        self.productsTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Products"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func configureData(){
        let product = Product()
        product.name = "Pokemon"
        product.priceText = "2 $"
        product.decimalPrice = 2
        product.currecy = .usd
        productList.append(product)
        let product2 = Product()
        product2.name = "Transformer"
        product2.priceText = "1000 $"
        product2.decimalPrice = 1000
        product2.currecy = .usd
        productList.append(product2)
        let product3 = Product()
        product3.name = "Puppet"
        product3.priceText = "1 AED"
        product3.decimalPrice = 1
        product3.currecy = .aed
        productList.append(product3)
        let product4 = Product()
        product4.name = "Puppet Collection"
        product4.priceText = "10 AED"
        product4.decimalPrice = 10
        product4.currecy = .aed
        productList.append(product4)
        let product5 = Product()
        product5.name = "Car"
        product5.priceText = "1000 AED"
        product5.decimalPrice = 1000
        product5.currecy = .aed
        productList.append(product5)
        
        self.productsTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showPaymentMethods"){
            if let paymentMethodsViewController = segue.destination as? PaymentMethodsViewController {
                paymentMethodsViewController.product = sender as? Product
            }
            
        }
    }
    
    @IBAction func openConfigurations(_ sender: UIButton) {
        CASHUServices.initiateTestingConfigurationsInParent(self)
    }
}

extension ProductsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListTableViewCell") as! ProductListTableViewCell
        cell.cellIndex = indexPath.row
        cell.delegate = self
        
        let product = self.productList[indexPath.row]
        cell.productNameLabel.text = product.name
        cell.productPriceLabel.text = product.priceText
        cell.productImageView.image = UIImage(named: product.name)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
}

extension ProductsListViewController : ProductListTableViewCellDelegate{
    func didTapOnPaymentButtonForCellWithIndex(cellIndex: Int) {
        self.performSegue(withIdentifier: "showPaymentMethods", sender: self.productList[cellIndex])
    }
}
