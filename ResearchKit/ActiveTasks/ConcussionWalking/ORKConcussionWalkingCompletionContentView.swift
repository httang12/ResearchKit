//
//  ORKConcussionWalkingCompletionContentView.swift
//  ResearchKit
//
//  Created by Arundev K S on 21/07/15.
//  Copyright (c) 2015 researchkit.org. All rights reserved.
//

import Foundation

public class ORKConcussionWalkingCompletionContentView : UIView {
    
    var title: UILabel!
    var stepCountLabel: UILabel!
    var distanceLabel: UILabel!
    var heartRateLabel: UILabel!
    
    var textColor: UIColor = UIColor.whiteColor()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //configure UI Elements
    private func configureUI() {
        
        //  Add step count label
        stepCountLabel = UILabel()
        stepCountLabel.frame = CGRectMake(10, 30, (self.frame.size.width-20)/2, 40)
        stepCountLabel.textColor = UIColor.blackColor()
        stepCountLabel.textAlignment = NSTextAlignment.Center
        stepCountLabel.text = "Total : 0.0 Steps"
        stepCountLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        stepCountLabel.numberOfLines = 0
        self.addSubview(stepCountLabel)
        
        //  Add step count label
        distanceLabel = UILabel()
        distanceLabel.frame = CGRectMake(self.frame.size.width/2, 30, (self.frame.size.width-20)/2, 40)
        distanceLabel.textColor = UIColor.blackColor()
        distanceLabel.textAlignment = NSTextAlignment.Center
        distanceLabel.text = "Distance : 0.0 feets"
        distanceLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        distanceLabel.numberOfLines = 0
        self.addSubview(distanceLabel)
        
        //  Add step count label
        heartRateLabel = UILabel()
        heartRateLabel.frame = CGRectMake(10, 100, self.frame.size.width-20, 40)
        heartRateLabel.textColor = UIColor.blackColor()
        heartRateLabel.textAlignment = NSTextAlignment.Center
        heartRateLabel.text = "Average heart rate : 0 BPM"
        heartRateLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        heartRateLabel.numberOfLines = 0
        self.addSubview(heartRateLabel)
        
    }
}