//
//  SimpleCameraController.swift
//  SimpleCamera
//
//  Created by andyron on 2017/6/5.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import AVFoundation

class SimpleCameraController: UIViewController {
    @IBOutlet var cameraButton: UIButton!

    // AVCaptureSession 是 AVFoundation 中的核心对象
    let captureSession = AVCaptureSession()
    
    var backFacingCamera: AVCaptureDevice?
    var frontFacingCamera: AVCaptureDevice?
    var currentDevice: AVCaptureDevice?
    
    var stillImageOutput: AVCaptureStillImageOutput?
    var stillImage: UIImage?
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //sessionPreset用来设置图片的质量和分辨率，AVCaptureSessionPresetPhoto代表 a full photo resolution
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        
        let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo) as! [AVCaptureDevice]
        
        for device in devices {
            if device.position == AVCaptureDevicePosition.back {
                backFacingCamera = device
            } else if device.position == AVCaptureDevicePosition.front {
                frontFacingCamera = device
            }
        }
        currentDevice = backFacingCamera
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice)
            
            stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput?.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            
            captureSession.addInput(captureDeviceInput)
            captureSession.addOutput(stillImageOutput)
            
            cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            view.layer.addSublayer(cameraPreviewLayer!)
            cameraPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            cameraPreviewLayer?.frame = view.layer.frame
            
            view.bringSubview(toFront: cameraButton)
            captureSession.startRunning()
            
        } catch {
            print(error)
        }
        
        
        
    }

    @IBAction func capture(_ sender: UIButton) {
        let videoConnection = stillImageOutput?.connection(withMediaType: AVMediaTypeVideo)
        stillImageOutput?.captureStillImageAsynchronously(from: videoConnection, completionHandler: {
            (imageDataSampleBuffer, error) -> Void in
            
            if let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer) {
                self.stillImage = UIImage(data: imageData)
                self.performSegue(withIdentifier: "showPhoto", sender: self)
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto" {
            let photoViewController = segue.destination as! PhotoViewController
            photoViewController.image = stillImage
        }
    }
}
