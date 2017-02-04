//
//  CameraViewController.swift
//  camera app
//
//  Created by Sergio Díaz Navarro on 1/31/17.
//  Copyright © 2017 Sergio Díaz Navarro. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    //Camera View
    @IBOutlet weak var btnTakePhoto: UIButton!
    @IBOutlet weak var btnFlash: UIButton!
    @IBOutlet weak var btnSettings: UIButton!
    @IBOutlet weak var btnReports: UIButton!

    
    //Photo Taken View
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnSaveToDevice: UIButton!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var imageView: UIImageView!

    
    
    //Camera
    @IBOutlet weak var cameraView: UIView!
    var captureSession = AVCaptureSession()
    var sessionOutput = AVCapturePhotoOutput()
    var previewLayer = AVCaptureVideoPreviewLayer()
    var imgCapturedImage : UIImage!


    //Flags
    var withFlash = false //enable/disbale flash
    var isCaptured = false //photo is about to be captured or wasalready taken

    
    override func viewDidLoad() {

        print("BEFORE")
        super.viewDidLoad()
        print("After")

        
        gestureSetup()
        state()
    }
    
    
    func state(){
    
        if (isCaptured){
            
            //Camera View
            btnTakePhoto.isHidden = true
            btnTakePhoto.isEnabled = false

            btnFlash.isHidden = true
            btnFlash.isEnabled = false

            btnSettings.isHidden = true
            btnSettings.isEnabled = false
            
            btnReports.isHidden = true
            btnReports.isEnabled = false

            
            
            //Photo Taken View
            btnCancel.isHidden = false
            btnCancel.isEnabled = true
            
            btnSaveToDevice.isHidden = false
            btnSaveToDevice.isEnabled = true
            
            btnConfirm.isHidden = false
            btnConfirm.isEnabled = true


            imageView.isHidden = false

            
        } else{
            
            //Camera View
            btnTakePhoto.isHidden = false
            btnTakePhoto.isEnabled = true

            btnFlash.isHidden = false
            btnFlash.isEnabled = true

            btnSettings.isHidden = false
            btnSettings.isEnabled = true

            btnReports.isHidden = false
            btnReports.isEnabled = true


            //Photo Taken View
            btnCancel.isHidden = true
            btnCancel.isEnabled = false
           
            btnSaveToDevice.isHidden = true
            btnSaveToDevice.isEnabled = false
            
            btnConfirm.isHidden = true
            btnConfirm.isEnabled = false
            
            imageView.isHidden = true
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let deviceSession = AVCaptureDeviceDiscoverySession(deviceTypes:
            [.builtInDuoCamera,.builtInWideAngleCamera], mediaType: AVMediaTypeVideo, position: .unspecified)
        
        for device in (deviceSession?.devices)!{
            
            if (device.position == AVCaptureDevicePosition.back){
                
                do {
                    
                    let input = try AVCaptureDeviceInput(device: device)
                    
                    if captureSession.canAddInput(input){
                        
                        captureSession.addInput(input)
                    }
                    
                    if captureSession.canAddOutput(sessionOutput){
                        
                        captureSession.addOutput(sessionOutput)
                        
                        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
                        previewLayer.connection.videoOrientation = .portrait
                        
                        cameraView.layer.addSublayer(previewLayer)
                        
                        //Before Capture
                        cameraView.addSubview(btnTakePhoto)
                        cameraView.addSubview(btnFlash)
                        cameraView.addSubview(btnSettings)
                        cameraView.addSubview(btnReports)


                        //After Capture
                        cameraView.addSubview(imageView)
                        cameraView.addSubview(btnCancel)
                        cameraView.addSubview(btnConfirm)
                        cameraView.addSubview(btnSaveToDevice)

                        previewLayer.position = CGPoint(x: self.cameraView.frame.width / 2, y: self.cameraView.frame.height / 2)
                        previewLayer.bounds = cameraView.frame
                        
                        captureSession.startRunning()
                    }
                    
                } catch let AVError {
                    
                    print(AVError)
                }
            }
        }
    }
    
    
    
    //Hide navigation bar
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }

    
    
    //MARK: - Camera Methods

    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        if let error = error {
            
            print(error.localizedDescription)
        }
        
        if let sampleBuffer = photoSampleBuffer, let previewBuffer = photoSampleBuffer, let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer){
            
            imgCapturedImage = UIImage(data: dataImage)
            imageView.image = imgCapturedImage
            isCaptured = true
            state()
            print("IMAGE CAPTURED")
            //captureSession.stopRunning()

        } else{
            print("IMAGE NOT CAPTURED")
        }
    }
    
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
    
        if (segue.identifier == "toSettings"){
            
            print("To settings")
        }
        
        if (segue.identifier == "toNavigation"){
            
            print("to navigation")
        }
    }
    
    
    @IBAction func unwindReport(unwindSegue : UIStoryboardSegue) {
        
    }
    

    //MARK: - Action Methods
    
    @IBAction func takesPhoto(_ sender: Any) {
        
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String : previewPixelType, kCVPixelBufferWidthKey as String : 160, kCVPixelBufferHeightKey as String:160]
        
        settings.previewPhotoFormat = previewFormat
        sessionOutput.capturePhoto(with: settings, delegate: self)
        
        
    }

    
    @IBAction func cancel(_ sender: Any) {
        
        print("Cancel pressed")
        isCaptured = false
        state()

    }
    
    @IBAction func saveToDevice(_ sender: UIButton) {
        
        print("Save to device pressed")
        
    }
    

        
    @IBAction func flash(_ sender: UIButton) {
        
        print("Flash pressed")
        
        if(withFlash){
            
            //flash config on
            //change flash button icon
            
        } else{
            
            //flash config off
            //change flash button icon
        }
    }
    
    
    // MARK: - Other methods
    func resetCamera(){
        isCaptured = false
        state()
        print("camera reseted")
    }
    
    
    @IBAction func settings(_ sender: UIButton) {
        
        print("Settings pressed")
        performSegue(withIdentifier: "toSettings", sender: nil)

    }
    
    @IBAction func reports(_ sender: UIButton) {
        
        print("Reports pressed")
        performSegue(withIdentifier: "toReports", sender: nil)


    }
    
    func gestureSetup(){
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(CameraViewController.swiped(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(CameraViewController.swiped(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)

    }
    
    func swiped(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.right:
                print("User Swiped Right")

            case UISwipeGestureRecognizerDirection.left:
                print("User Swiped Left")
            
            default:
                break
                
            }
        }
    }
}
