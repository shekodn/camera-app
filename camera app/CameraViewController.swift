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
    
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var btnTakePhoto: UIButton!
    
    var captureSession = AVCaptureSession()
    var sessionOutput = AVCapturePhotoOutput()
    var previewLayer = AVCaptureVideoPreviewLayer()
    var imgCapturedImage : UIImage!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindPicture(unwindSegue:UIStoryboardSegue){
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
                        cameraView.addSubview(btnTakePhoto)
                        
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
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        
        print("SHOULD PERFROM")
        
        
        return true
        
    }
    
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        if let error = error {
            
            print(error.localizedDescription)
        }
        
        if let sampleBuffer = photoSampleBuffer, let previewBuffer = photoSampleBuffer, let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer){
            
            imgCapturedImage = UIImage(data: dataImage)
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
        
        if (segue.identifier == "toPicture"){
            
            print("Switched to photo view controller")
            
            let viewPicture = segue.destination as! PictureViewController
            print("SUCCESS")
            
            viewPicture.canTakePicture()

        }
    }
}
