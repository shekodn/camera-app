//
//  ReportViewController.swift
//  camera app
//
//  Created by Sergio Díaz Navarro on 2/1/17.
//  Copyright © 2017 Sergio Díaz Navarro. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var areas = ["Area 1", "Area 2","Area 3","Area 4","Area 5","Area 6","Area 7","Area 8", ];

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    //MARK: - Segue
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
    
        
    }

    
    // MARK: - Picker View
    
    @IBOutlet weak var pickerAreas: UIPickerView!
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return areas[row]
    }
    
    // returns the number of 'columns' to display.
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        
        return 1
    }
    
    
    // returns the # of rows in each component..
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return areas.count
    }
    
    
    // MARK: - Other Methods
    @IBAction func hidesKeyboard(_ sender: Any) {
        
        view.endEditing(true)
    }
    
    
    @IBAction func submitReport(_ sender: UIButton) {
    
        let alert = UIAlertController(title: "Congratulations!", message: "Your report was successfully sent!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
            
            CameraViewController().resetCamera()

        }))
       
        present(alert,animated: true, completion: nil)
    }
    
    
    func backToCamera(){
        
        CameraViewController().resetCamera()
    }
}
