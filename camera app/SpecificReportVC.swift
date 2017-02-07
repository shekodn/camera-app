//
//  SpecificReportVC.swift
//  camera app
//
//  Created by Sergio Díaz Navarro on 2/4/17.
//  Copyright © 2017 Sergio Díaz Navarro. All rights reserved.
//

import UIKit

class SpecificReportVC: UIViewController {

    
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var tvDescription: UITextView!

    var sReportName = "No name"
    var sReportDescription = "No description."
    
    func setDate(){
        
        let date = Date()
        let dateFormat = DateFormatter()
        
        //12,12,2012
        dateFormat.dateFormat = "d/M/y"
        lbDate.text = String(describing: dateFormat.string(from: date))
    }
    
    
    
    func loadReport(){
        
        self.title = sReportName
        tvDescription.text = sReportDescription
        setDate()

        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadReport()
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
