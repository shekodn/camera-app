//
//  ReportViewController.swift
//  camera app
//
//  Created by Sergio Díaz Navarro on 2/1/17.
//  Copyright © 2017 Sergio Díaz Navarro. All rights reserved.
//

import UIKit

class FormViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //Input fields
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var tfArea: UITextField!
    
    //Buttons
    @IBOutlet weak var btnSubmit: UIButton!

    
    //Variables
    var areas = ["Area 1", "Area 2","Area 3","Area 4","Area 5","Area 6","Area 7","Area 8"];
    var pickerView = UIPickerView()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerViewSettings()
    }
    
    

    
    
    //MARK: - Segue
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        let button = sender as! UIButton
        
        if button.tag == 1 { // 1 = submit button
            
        }

        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        
        let button = sender as! UIButton
        
        if button.tag == 1 {
            
            print("SUBMIT")
            submitReport(btnSubmit)
            
        } else{
            
            print("BACK")
        }

    }
    
    
    // MARK: - Picker View
    
    //Presets for the picker view to work
    func pickerViewSettings(){
     
        //Picker view settings
        pickerView.delegate = self
        pickerView.dataSource = self
        tfArea.inputView = pickerView

    }
    
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

    //selects the current option in the picker view
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        tfArea.text = areas[row]
    }
    
    
    // MARK: - Other Methods
    @IBAction func hidesKeyboard(_ sender: Any) {
        
        view.endEditing(true)
    }
    
    
    @IBAction func submitReport(_ sender: UIButton) {
    
        let alert = UIAlertController(title: "Congratulations!", message: "Your report was successfully sent!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
            
            print("add action")
            
        }))
       
        present(alert,animated: true, completion: { action in
            
            print("present alert")
        })
    }
}
