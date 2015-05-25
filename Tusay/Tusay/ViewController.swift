//
//  ViewController.swift
//  Tusay
//
//  Created by 丁松 on 15/3/22.
//  Copyright (c) 2015年 丁松. All rights reserved.
//


/*
import UIKit
import AVFoundation

class ViewController: UIViewController {

let captureSession = AVCaptureSession()
var previewLayer : AVCaptureVideoPreviewLayer?
let stillImageOutput = AVCaptureStillImageOutput()
// If we find a device we'll store it here for later use
var captureDevice : AVCaptureDevice?

var devicePoint : CGPoint = CGPoint(x: 0.5, y: 0.5)

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
//device.focusMode = AVCaptureFocusMode.AutoFocus  //.Locked
self.focus(AVCaptureFocusMode.ContinuousAutoFocus, exposureMode: AVCaptureExposureMode.ContinuousAutoExposure, point: devicePoint, monitorSubjectAreaChange: false)
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

stillImageOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
captureSession.addOutput(stillImageOutput)
captureSession.startRunning()
}

//对焦
func focus(focusMode: AVCaptureFocusMode, exposureMode: AVCaptureExposureMode, point: CGPoint, monitorSubjectAreaChange: Bool) {
if let device = captureDevice {
var error : NSError?
if device.lockForConfiguration(&error) {
if device.focusPointOfInterestSupported && device.isFocusModeSupported(focusMode) {
device.focusMode = focusMode
device.focusPointOfInterest = point
}
if device.exposurePointOfInterestSupported && device.isExposureModeSupported(exposureMode) {
device.exposureMode = exposureMode
device.exposurePointOfInterest = point
}
device.subjectAreaChangeMonitoringEnabled = monitorSubjectAreaChange
device.unlockForConfiguration()
} else {
println("Error setting focus")
}
}
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
*/

import UIKit
import AVFoundation

class ViewController: UIViewController {
	//UIImagePickerControllerDelegate,UINavigationControllerDelegate
	
	let captureSession = AVCaptureSession()
	var previewLayer : AVCaptureVideoPreviewLayer?
	let stillImageOutput = AVCaptureStillImageOutput()
	
	//let dealViewInfo = DealViewInfo(frame:(CGRectMake(0,  UIScreen.mainScreen().bounds.height - 200,  UIScreen.mainScreen().bounds.width, 150)))
	//let timerView  = TimerView(frame: CGRectMake(UIScreen.mainScreen().bounds.width - 70, 30, 50, 50))
	let screenSize =  UIScreen.mainScreen().bounds
	let captureButton = UIButton(frame:(CGRectMake (0,UIScreen.mainScreen().bounds.height - 50,UIScreen.mainScreen().bounds.width,50)))
	let galleryButton = UIButton(frame:(CGRectMake (-25,UIScreen.mainScreen().bounds.height - 50,90,50)))
	var imageTaken : UIImage!
	var devicePoint : CGPoint = CGPoint(x: 0.5, y: 0.5)
	let picker = UIImagePickerController()
	
	let autofocusCircle = UIButton(frame:(CGRectMake (0,0,70,70)))
	let autofocusCircleInner = UIButton(frame:(CGRectMake (0,0,50,50)))
	let autofocusCircleInnerMost = UIButton(frame:(CGRectMake (0,0,30,30)))
	let autofocusBullseye = UIButton(frame:(CGRectMake (0,0,10,10)))
	
	
	// If we find a device we'll store it here for later use
	var captureDevice : AVCaptureDevice?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		//picker.delegate = self
		
		scanDevice()
	}
	
	
	override func viewWillAppear(animated: Bool) {
		//createCameraUI()
	}
	
	
	
	
	//MARK camera
	
	func scanDevice() {
		captureSession.sessionPreset = AVCaptureSessionPresetHigh
		let devices = AVCaptureDevice.devices()
		println(devices)
		//picker.delegate = self
		
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
	
	func beginSession() {
		//configureDevice
		if let device = captureDevice {
			device.lockForConfiguration(nil)
			self.focus(AVCaptureFocusMode.ContinuousAutoFocus, exposureMode: AVCaptureExposureMode.ContinuousAutoExposure, point: devicePoint, monitorSubjectAreaChange: false)
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
		
		stillImageOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
		captureSession.addOutput(stillImageOutput)
		captureSession.startRunning()
	}
	
	func focus(focusMode: AVCaptureFocusMode, exposureMode: AVCaptureExposureMode, point: CGPoint, monitorSubjectAreaChange: Bool) {
		if let device = captureDevice {
			var error : NSError?
			if device.lockForConfiguration(&error) {
				if device.focusPointOfInterestSupported && device.isFocusModeSupported(focusMode) {
					device.focusMode = focusMode
					device.focusPointOfInterest = point
				}
				if device.exposurePointOfInterestSupported && device.isExposureModeSupported(exposureMode) {
					device.exposureMode = exposureMode
					device.exposurePointOfInterest = point
				}
				device.subjectAreaChangeMonitoringEnabled = monitorSubjectAreaChange
				device.unlockForConfiguration()
			} else {
				println("Error setting focus")
			}
		}
	}
	
	
	func updateDeviceSettings(focusValue : Float, isoValue : Float) {
		if let device = captureDevice {
			if(device.lockForConfiguration(nil)) {
				device.setFocusModeLockedWithLensPosition(focusValue, completionHandler: { (time) -> Void in
					//
				})
				
				// Adjust the iso to clamp between minIso and maxIso based on the active format
				let minISO = device.activeFormat.minISO
				let maxISO = device.activeFormat.maxISO
				let clampedISO = isoValue * (maxISO - minISO) + minISO
				
				device.setExposureModeCustomWithDuration(AVCaptureExposureDurationCurrent, ISO: clampedISO, completionHandler: { (time) -> Void in
					//
				})
				
				device.unlockForConfiguration()
			}
		}
	}
	
	func touchPercent(touch : UITouch) -> CGPoint {
		// Get the dimensions of the screen in points
		let screenSize = UIScreen.mainScreen().bounds.size
		
		// Create an empty CGPoint object set to 0, 0
		var touchPer = CGPointZero
		
		// Set the x and y values to be the value of the tapped position, divided by the width/height of the screen
		touchPer.x = touch.locationInView(self.view).x / screenSize.width
		touchPer.y = touch.locationInView(self.view).y / screenSize.height
		
		// Return the populated CGPoint
		return touchPer
	}
	
	
//	override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//		var anyTouch = touches.anyObject() as UITouch
//		var touchPercent = anyTouch.locationInView(self.view).x / screenWidth
//		//focusTo(Float(touchPercent))
//	}
	
	
	override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
		let touchEvent = touches.anyObject() as UITouch  //touches.first as NSSet
		        let touchView = touchEvent.locationInView(self.view)
		        let touchPer = touchPercent(touchEvent)
		
		        createAutofocusCircle(autofocusCircle,point:touchView,widthAndHeight:70,time:0.8)
		        createAutofocusCircle(autofocusCircleInner,point:touchView,widthAndHeight:50,time:0.7)
		        createAutofocusCircle(autofocusCircleInnerMost,point:touchView,widthAndHeight:30,time:0.6)
		        createAutofocusCircle(autofocusBullseye,point:touchView,widthAndHeight:10,time:0.3)
		
		        self.focus(AVCaptureFocusMode.AutoFocus, exposureMode: AVCaptureExposureMode.AutoExpose, point: devicePoint, monitorSubjectAreaChange: false)
	}
	
	func createAutofocusCircle(button:UIButton,point:CGPoint,widthAndHeight:CGFloat,time:CFTimeInterval ) {
		button.layer.borderColor = UIColor.whiteColor().CGColor
		button.layer.borderWidth = 2
		button.layer.cornerRadius = widthAndHeight/2
		button.frame = CGRectMake(CGFloat(point.x) - widthAndHeight/2, CGFloat(point.y) - widthAndHeight/2 , widthAndHeight, widthAndHeight)
		self.view.addSubview(button)
		createAnimation(button,time:time)
	}
	
	func createAnimation(button:UIButton,time:CFTimeInterval) {
		var selectionAnimation = CABasicAnimation(keyPath: "borderColor")
		selectionAnimation.fromValue = UIColor.whiteColor().CGColor
		selectionAnimation.toValue = UIColor.grayColor().CGColor
		selectionAnimation.timeOffset = time
		selectionAnimation.repeatCount = 3
		selectionAnimation.duration = time
		selectionAnimation.delegate = self
		button.layer.addAnimation(selectionAnimation, forKey: "selectionAnimation")
	}
	
	//	override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
	//		autofocusCircle.removeFromSuperview()
	//		autofocusCircleInner.removeFromSuperview()
	//		autofocusCircleInnerMost.removeFromSuperview()
	//		autofocusBullseye.removeFromSuperview()
	//
	//	}
	
	
	//	func createCameraUI() {
	//		dealViewInfo.lblCompanyName.text = "The Bruffin Shop"
	//		self.view.addSubview(dealViewInfo)
	//		self.view.addSubview(timerView)
	//		captureButtonCreation()
	//		galleryButtonCreation()
	//	}
	
	//	func captureButtonCreation() {
	//		captureButton.backgroundColor = UIColor.flatMintColor()
	//		captureButton.setTitle("Capture Deal", forState: .Normal)
	//		captureButton.titleLabel?.font = UIFont(name: "Montserrat", size: 16)
	//		captureButton.titleLabel?.textColor = UIColor.whiteColor()
	//		captureButton.addTarget(self, action: "takePhoto", forControlEvents: UIControlEvents.TouchUpInside)
	//
	//		self.view.addSubview(captureButton)
	//	}
	//	func galleryButtonCreation() {
	//		galleryButton.backgroundColor = UIColor.whiteColor()
	//		galleryButton.layer.cornerRadius = 25
	//		galleryButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
	//		galleryButton.setImage(UIImage(named: "photos"), forState: .Normal)
	//		galleryButton.addTarget(self, action: "photoFromLibrary", forControlEvents: UIControlEvents.TouchUpInside)
	//
	//		self.view.addSubview(galleryButton)
	//	}
	
	
	//	func photoFromLibrary() {
	//		picker.allowsEditing = false //2
	//		picker.sourceType = .PhotoLibrary //3
	//		picker.modalPresentationStyle = .Popover
	//		presentViewController(picker, animated: true, completion: nil)//4
	//	}
	
	
	
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		//		if segue.identifier == "imageTaken" {
		//			let vc = (segue.destinationViewController as ImageTakenVC)
		//			vc.image = self.imageTaken
		//			vc.dealViewInfo = dealViewInfo
		//			vc.timerView = timerView
		//		}
	}
	
	
	
	
	//	func takePhoto(){
	//		println("pressed")
	//		if let videoConnection = self.stillImageOutput.connectionWithMediaType(AVMediaTypeVideo){//take a photo here}
	//			self.stillImageOutput.captureStillImageAsynchronouslyFromConnection(self.stillImageOutput.connectionWithMediaType(AVMediaTypeVideo), completionHandler: { (imageDataSampleBuffer, error) -> Void in
	//				if ((imageDataSampleBuffer) != nil) {
	//					let imageData : NSData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
	//					let image : UIImage = UIImage(data: imageData)!
	//					println("Save me")
	//					self.imageTaken = image
	//					self.performSegueWithIdentifier("imageTaken", sender: self)
	//				}
	//			})
	//		}
	//	}
	
	
	
	
	//MARK: - Delegates
	//What to do when the picker returns with a photo
	//	func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
	//		var chosenImage = info[UIImagePickerControllerOriginalImage] as UIImage //2
	//		self.imageTaken = chosenImage
	//		dismissViewControllerAnimated(true, completion: nil) //5
	//		self.performSegueWithIdentifier("imageTaken", sender: self)
	//	}
}



