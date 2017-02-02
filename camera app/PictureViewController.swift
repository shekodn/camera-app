//
//  PictureViewController.swift
//  camera app
//
//  Created by Sergio Díaz Navarro on 2/1/17.
//  Copyright © 2017 Sergio Díaz Navarro. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var imgImage : UIImageView!

    
    func canTakePicture(){
        
        print("canTakePicture")
        
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
