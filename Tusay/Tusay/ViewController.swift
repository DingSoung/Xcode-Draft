//
//  ViewController.swift
//  Tusay
//
//  Created by 丁松 on 15/3/22.
//  Copyright (c) 2015年 丁松. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
	
	let captureSession = AVCaptureSession()
	var previewLayer : AVCaptureVideoPreviewLayer?
	// If we find a device we'll store it here for later use
	var captureDevice : AVCaptureDevice?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		captureSession.sessionPreset = AVCaptureSessionPresetLow
		let devices = AVCaptureDevice.devices()
		println(devices)
		
		// Loop through all the capture devices on this phone
		for device in devices {
			// Make sure this particular device supports video
			if (device.hasMediaType(AVMediaTypeVideo)) {
				// Finally check the position and confirm we've got the back camera
				if(device.position == AVCaptureDevicePosition.Back) {
					captureDevice = device as? AVCaptureDevice
					if captureDevice != nil {
						println("Capture device found")
						beginSession()
					}
				}
			}
		}
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	func beginSession() {
		//configureDevice
		if let device = captureDevice {
			device.lockForConfiguration(nil)
			device.focusMode = AVCaptureFocusMode.AutoFocus  //.Locked
			device.unlockForConfiguration()
		}
		
		var err : NSError? = nil
		captureSession.addInput(AVCaptureDeviceInput(device: captureDevice, error: &err))
		
		if err != nil {
			println("error: \(err?.localizedDescription)")
		}
		
		previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
		self.view.layer.addSublayer(previewLayer)
		previewLayer?.frame = self.view.layer.frame
		captureSession.startRunning()
	}
	
	func focusTo(value : Float) {
		if let device = captureDevice {
			if(device.lockForConfiguration(nil)) {
				device.setFocusModeLockedWithLensPosition(value, completionHandler: { (time) -> Void in
					//
				})
				device.unlockForConfiguration()
			}
		}
	}
 
	
	
	let screenWidth = UIScreen.mainScreen().bounds.size.width
	
	override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
		var anyTouch = touches.anyObject() as UITouch
		var touchPercent = anyTouch.locationInView(self.view).x / screenWidth
		focusTo(Float(touchPercent))
	}
 
	override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
		var anyTouch = touches.anyObject() as UITouch
		var touchPercent = anyTouch.locationInView(self.view).x / screenWidth
		focusTo(Float(touchPercent))
	}
 

 

	
	
	
}

