//
//  NavigationVC.swift
//  camera app
//
//  Created by Sergio Díaz Navarro on 2/4/17.
//  Copyright © 2017 Sergio Díaz Navarro. All rights reserved.
//

import UIKit

class NavigationVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Status bar white font
//        self.navigationBar.barStyle = UIBarStyle.black
//        self.navigationBar.tintColor = UIColor.white
        
        self.navigationController?.navigationBar.tintColor = UIColor.white



    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
