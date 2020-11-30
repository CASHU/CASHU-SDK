//
//  ViewController.swift
//  TestSDK
//
//  Created by Amr Saied on 10/4/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func openSDK(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Products", bundle: nil)
        
        let nav1 = UINavigationController()
         let mainView = ViewController(nibName: nil, bundle: nil) //ViewController = Name of your controller

        
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductsListViewController")
        nav1.viewControllers = [vc]

        self.present(nav1, animated: true)
        
    }
}

