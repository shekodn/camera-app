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
    
   
    
    //Buttons
    
    //Camera View
    @IBOutlet weak var btnTakePhoto: UIButton!
    @IBOutlet weak var btnFlash: UIButton!

    
    //Photo Taken View
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnSaveToDevice: UIButton!
    @IBOutlet weak var btnConfirm: UIButton!
    
    
    //Camera
    @IBOutlet weak var cameraView: UIView!
    var captureSession = AVCaptureSession()
    var sessionOutput = AVCapturePhotoOutput()
    var previewLayer = AVCaptureVideoPreviewLayer()
    var imgCapturedImage : UIImage!
    
    
    var withFlash = false
    var isCaptured = false

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        state()

    }
    
    
    func state(){
    
        if (isCaptured){
            
            //Camera View
            btnTakePhoto.isHidden = true
            btnFlash.isHidden = true
            
            
            //Photo Taken View
            btnCancel.isHidden = false
            btnSaveToDevice.isHidden = false
            btnConfirm.isHidden = false
            imageView.isHidden = false

            
        } else{
            
            //Camera View
            btnTakePhoto.isHidden = false
            btnFlash.isHidden = false
            
            
            //Photo Taken View
            btnCancel.isHidden = true
            btnSaveToDevice.isHidden = true
            btnConfirm.isHidden = true
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
    
    @IBAction func takesPhoto(_ sender: Any) {
        
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [kCVPixelBufferPixelFormatTypeKey as String : previewPixelType, kCVPixelBufferWidthKey as String : 160, kCVPixelBufferHeightKey as String:160]
        
        settings.previewPhotoFormat = previewFormat
        sessionOutput.capturePhoto(with: settings, delegate: self)
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        
        print("Switched to photo View controller")
        
        
    }
    
    //MARK: - Button Methods
    
    
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
        withFlash = !withFlash
        
        if(withFlash){
            
            
        }

    }
    
    
    @IBAction func unwindReport(unwindSegue : UIStoryboardSegue) {
        
        //
    }

    
}
