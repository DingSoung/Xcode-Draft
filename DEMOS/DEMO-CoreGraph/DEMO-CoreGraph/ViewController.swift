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
    let descartesView = DescartesView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.addSubview(self.pieChartView)
        //self.view.addSubview(self.wordCloudView)
        //self.view.addSubview(self.gaugeChartView)
        self.view.addSubview(self.descartesView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let rect = self.view.bounds;
        
        self.pieChartView.frame = CGRectMake(0, 0, rect.size.width * 0.5, rect.size.height * 0.5)
        
        self.wordCloudView.frame = CGRectMake(rect.size.width * 0.5, 0, rect.size.width * 0.5, rect.size.height * 0.5)
        
        self.gaugeChartView.frame = CGRectMake(0, rect.size.height * 0.5, rect.size.width * 0.5, rect.size.height * 0.5)
        
        self.descartesView.frame = self.view.bounds// CGRectMake(rect.size.width * 0.5, rect.size.height * 0.5, rect.size.width * 0.5, rect.size.height * 0.5)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

