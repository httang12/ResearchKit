//
//  ORKConcussionWalkingContentView.swift
//  ResearchKit
//
//  Created by Arundev K S on 13/07/15.
//  Copyright (c) 2015 researchkit.org. All rights reserved.
//

import Foundation
import UIKit
import ResearchKit.Private

public class ORKConcussionWalkingContentView : UIView {
    
    var title: UILabel!
    var descriptionLabel: UILabel!
    var minCounterLabel: UILabel!
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
        
        //add title label
        title = UILabel()
        title.frame = CGRectMake(10, 10, self.frame.size.width-20, 50)
        title.textColor = UIColor.blackColor()
        title.textAlignment = NSTextAlignment.Center
        title.text = "Walk in a steady pace for 6 minutes"
        title.font = UIFont.systemFontOfSize(20.0)
        self.addSubview(title)
        
        //  Minute counter label
        minCounterLabel = UILabel()
        minCounterLabel.frame = CGRectMake(10, 70, self.frame.size.width-20, 120)
        minCounterLabel.textColor = UIColor.blackColor()
        minCounterLabel.textAlignment = NSTextAlignment.Center
        minCounterLabel.text = "06:00"
        minCounterLabel.font = UIFont.boldSystemFontOfSize(60.0)
        self.addSubview(minCounterLabel)
        
        //add stepCountLabel
        stepCountLabel = UILabel()
        stepCountLabel.frame = CGRectMake(10, 200, (self.frame.size.width-20)/2, 40)
        stepCountLabel.textColor = UIColor.blackColor()
        stepCountLabel.textAlignment = NSTextAlignment.Center
        stepCountLabel.text = "0 Steps"
        stepCountLabel.font = UIFont.systemFontOfSize(18)
        self.addSubview(stepCountLabel)

        //add distance label
        distanceLabel = UILabel()
        distanceLabel.frame = CGRectMake(self.frame.size.width/2, 200, (self.frame.size.width-20)/2, 40)
        distanceLabel.textColor = UIColor.blackColor()
        distanceLabel.textAlignment = NSTextAlignment.Center
        distanceLabel.text = "0 Feets"
        distanceLabel.font = UIFont.systemFontOfSize(18)
        self.addSubview(distanceLabel)

        //  Add heart rate label
        heartRateLabel = UILabel()
        heartRateLabel.frame = CGRectMake(10, 250, self.frame.size.width-20, 40)
        heartRateLabel.textColor = UIColor.blackColor()
        heartRateLabel.textAlignment = NSTextAlignment.Center
        heartRateLabel.text = "0 BPM"
        heartRateLabel.font = UIFont.systemFontOfSize(18)
        self.addSubview(heartRateLabel)

    }
}