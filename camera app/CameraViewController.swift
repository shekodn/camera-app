//
//  CameraViewController.swift
//  camera app
//
//  Created by Sergio Díaz Navarro on 1/31/17.
//  Copyright © 2017 Sergio Díaz Navarro. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var btnTakePhoto: UIButton!
    
    var captureSession = AVCaptureSession()
    var sessionOutput = AVCapturePhotoOutput()
    var previewLayer = AVCaptureVideoPreviewLayer()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
}
