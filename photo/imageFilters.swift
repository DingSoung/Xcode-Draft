//
//  imageFiltersController.swift
//  ThumbsOnTheRun
//
//  Created by 丁松 on 14-9-14.
//  Copyright (c) 2014年 丁松. All rights reserved.
//
// ref https://github.com/zhangao0086/iOS-CoreImage-Swift.git

import UIKit

class imageFilters: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var filterPicker: UIPickerView!
    @IBOutlet weak var filterSeg: UISegmentedControl!
    
    let filterTable = CIFilter.filterNamesInCategory(kCICategoryColorEffect)
    var filter: CIFilter!
    let context = CIContext(options:nil)
    var currentImage = UIImage(named:"default.jpg")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.imageView.layer.shadowOpacity = 0.8
        self.imageView.layer.shadowColor = UIColor.blackColor().CGColor
        self.imageView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.imageView.image = currentImage
        
        filterPicker.dataSource = self
        filterPicker.delegate = self
        filterPicker.hidden = true
        getAllSystemFilter()
        println(filterTable)
        
        //insertBlurView1(filterSeg,style: UIBlurEffectStyle.Light)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getAllSystemFilter() {
        let filterNames = CIFilter.filterNamesInCategory(kCICategoryColorEffect)
        println(filterNames.count)
        println(filterNames)
        
        for filterName in filterNames {
            let filter = CIFilter(name: filterName as String)
            let attributes = filter.attributes()
            println(attributes)
        }
    }
    
    //ex. insertBlurView(filterSeg,style: UIBlurEffectStyle.Light)
    func insertBlurView1(view: UIView,  style: UIBlurEffectStyle) {
        view.backgroundColor = UIColor.clearColor()
        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        visualEffectView.frame = view.bounds
        visualEffectView.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        view.addSubview(visualEffectView)
    }
    func insertBlurView2(view: UIView,  style: UIBlurEffectStyle) {
        view.backgroundColor = UIColor.clearColor()
        var visualEffective = UIBlurEffect(style: style)
        var visualEffectiveView = UIVisualEffectView(effect: visualEffective)
        visualEffectiveView.frame = view.bounds
        view.insertSubview(visualEffectiveView, atIndex: 0)
    }
    
    func applayFilter(filterName : String) {
        var filterType = CIFilter(name: filterName)
        let image = CIImage(image: currentImage)
        filterType.setValue(image, forKey: kCIInputImageKey)
        let data =  filterType.outputImage
        self.imageView.image = UIImage(CGImage:context.createCGImage(data, fromRect:data.extent()))
    }
    
    func saveImage(sender: AnyObject) {
        applayFilter(filterTable[filterPicker.selectedRowInComponent(0)] as String)
        currentImage = self.imageView.image!
        filterPicker.hidden = true
    }
    @IBAction func filterSegment(sender: AnyObject) {
        switch sender.selectedSegmentIndex {
        case 0:
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
            var destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("imagePicker") as UIViewController
            //presentViewController(imagePicker(), animated: true,
            //    completion: {
            //    (void) -> Void in
            //do some thing
            //})
            self.presentViewController(destViewController, animated:false, completion:nil)
            
            //            var inputImage = CIImage(image: imageCurrent)
            //            let filters = inputImage.autoAdjustmentFilters() as [CIFilter]
            //            for filter: CIFilter in filters {
            //                filter.setValue(inputImage, forKey: kCIInputImageKey)
            //                inputImage = filter.outputImage
            //            }
            //            let cgImage = context.createCGImage(inputImage, fromRect: inputImage.extent())
            //            self.imageView.image = UIImage(CGImage: cgImage)
        case 1:
            //Filter
            filterPicker.hidden = false
        case 2:
            self.imageView.image = UIImage(named:"default.jpg")
        default:
            break
        }
        filterSeg.momentary = true
    }
    @IBAction func showerOperater(sender: AnyObject) {
        filterPicker.hidden = false
    }
    
    
    
    //UIPickerViewDataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return filterTable.count
    }
    //UIPickerViewDelegate
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        var filterType = filterTable[row] as String
        //filterType
        return filterType
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)  {
        applayFilter(filterTable[filterPicker.selectedRowInComponent(0)] as String)
    }
}
