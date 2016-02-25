//
//  ViewController.swift
//  DEMO-CoreGraph
//
//  Created by Alex D. on 2/19/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let pieChartView = PieChartView()
    let wordCloudView = WordCloudView()
    let gaugeChartView = GaugeChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.pieChartView)
        self.view.addSubview(self.wordCloudView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if (UIInterfaceOrientationIsPortrait(UIApplication.sharedApplication().statusBarOrientation)) {
            self.pieChartView.frame = self.view.bounds
            self.pieChartView.frame.size.height = self.view.bounds.size.height * 0.25
            
            self.wordCloudView.frame = self.view.bounds
            self.wordCloudView.frame.origin.y = self.view.bounds.height * 0.25
            self.wordCloudView.frame.size.height = self.view.bounds.size.height * 0.25
            
            self.gaugeChartView.frame = self.view.bounds
            self.gaugeChartView.frame.origin.y = self.view.bounds.height * 0.5
            self.gaugeChartView.frame.size.height = self.view.bounds.size.height * 0.25
        } else {
            self.pieChartView.frame = self.view.bounds
            self.pieChartView.frame.size.width = self.view.bounds.size.width * 0.25
            
            self.wordCloudView.frame = self.view.bounds
            self.wordCloudView.frame.origin.x = self.view.bounds.width * 0.25
            self.wordCloudView.frame.size.width = self.view.bounds.size.width * 0.25
            
            self.gaugeChartView.frame = self.view.bounds
            self.gaugeChartView.frame.origin.x = self.view.bounds.width * 0.5
            self.gaugeChartView.frame.size.width = self.view.bounds.size.width * 0.25
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}

