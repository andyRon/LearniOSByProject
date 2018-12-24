//
//  SimpleCameraController.swift
//  SimpleCamera
//
//  Created by andyron on 2017/6/5.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import AVFoundation

class SimpleCameraController: UIViewController, AVCapturePhotoCaptureDelegate {
    @IBOutlet var cameraButton: UIButton!

    // AVCaptureSession 是 AVFoundation 中的核心对象
    let captureSession = AVCaptureSession()
    
    var backFacingCamera: AVCaptureDevice?
    var frontFacingCamera: AVCaptureDevice?
    var currentDevice: AVCaptureDevice?
    
    var stillImageOutput: AVCapturePhotoOutput?
    var stillImage: UIImage?
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var toggleCameraGestureRecognizer = UISwipeGestureRecognizer()
    
    var zoomInGestureRecognizer = UISwipeGestureRecognizer()
    var zoomOutGestureRecognizer = UISwipeGestureRecognizer()
    
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
            
            stillImageOutput = AVCapturePhotoOutput()
//            stillImageOutput?.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
//            let setting = AVCapturePhotoSettings()
//            setting.previewPhotoFormat = [AVVideoCodecKey: AVVideoCodecJPEG]
//            AVCapturePhotoSettings.fomat
            
            captureSession.addInput(captureDeviceInput)
            captureSession.addOutput(stillImageOutput)
            
            cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            view.layer.addSublayer(cameraPreviewLayer!)
            cameraPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            cameraPreviewLayer?.frame = view.layer.frame
            
            view.bringSubview(toFront: cameraButton)
            captureSession.startRunning()
            
            toggleCameraGestureRecognizer.direction = .up
            toggleCameraGestureRecognizer.addTarget(self, action: #selector(toggleCamera))
            view.addGestureRecognizer(toggleCameraGestureRecognizer)
            
            zoomInGestureRecognizer.direction = .right
            zoomInGestureRecognizer.addTarget(self, action: #selector(zoomIn))
            view.addGestureRecognizer(zoomInGestureRecognizer)
            
            zoomOutGestureRecognizer.direction = .left
            zoomOutGestureRecognizer.addTarget(self, action: #selector(zoomOut))
            view.addGestureRecognizer(zoomOutGestureRecognizer)
            
            
        } catch {
            print(error)
        }
        
        
        
    }
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        if let error = error {
            print(error.localizedDescription)
        }
        
        if let sampleBuffer = photoSampleBuffer, let previewBuffer = previewPhotoSampleBuffer, let dataImage = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: sampleBuffer, previewPhotoSampleBuffer: previewBuffer) {
//            print(image: UIImage(data: dataImage)?.size)
            self.stillImage = UIImage(data: dataImage)
        } else {
            
        }
    }
    
    @IBAction func capture(_ sender: UIButton) {
//        let videoConnection = stillImageOutput?.connection(withMediaType: AVMediaTypeVideo)
//        stillImageOutput?.captureStillImageAsynchronously(from: videoConnection, completionHandler: {
//            (imageDataSampleBuffer, error) -> Void in
//            
//            if let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer) {
//                self.stillImage = UIImage(data: imageData)
//                self.performSegue(withIdentifier: "showPhoto", sender: self)
//            }
//        })
        
        if let stillImage = self.stillImage {
            self.performSegue(withIdentifier: "showPhoto", sender: self)
        }

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto" {
            let photoViewController = segue.destination as! PhotoViewController
            photoViewController.image = stillImage
        }
    }
    
    // MARK: - 手势处理，转变前后摄像头
    func toggleCamera() {
        captureSession.beginConfiguration()
        
        let newDevice = (currentDevice?.position == AVCaptureDevicePosition.back) ? frontFacingCamera : backFacingCamera
        
        for input in captureSession.inputs {
            captureSession.removeInput(input as! AVCaptureDeviceInput)
        }
        
        let cameraInput: AVCaptureDeviceInput
        do {
            cameraInput = try AVCaptureDeviceInput(device: newDevice)
        } catch {
            print(error)
            return
        }
        
        if captureSession.canAddInput(cameraInput) {
            captureSession.addInput(cameraInput)
        }
        
        currentDevice = newDevice
        captureSession.commitConfiguration()
    }
    
    func zoomIn() {
        if let zoomFactor = currentDevice?.videoZoomFactor {
            if zoomFactor < 5.0 {
                let newZoomFactor = min(zoomFactor + 1.0, 5.0)
                do {
                    try currentDevice?.lockForConfiguration()
                    currentDevice?.ramp(toVideoZoomFactor: newZoomFactor, withRate: 1.0)
                    currentDevice?.unlockForConfiguration()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func zoomOut() {
        if let zoomFactor = currentDevice?.videoZoomFactor {
            if zoomFactor > 1.0 {
                let newZoomFactor = min(zoomFactor - 1.0, 1.0)
                do {
                    try currentDevice?.lockForConfiguration()
                    currentDevice?.ramp(toVideoZoomFactor: newZoomFactor, withRate: 1.0)
                    currentDevice?.unlockForConfiguration()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    // MARK: - Segues
    @IBAction func unwindToCameraView(segue: UIStoryboardSegue) {
        
    }
}
