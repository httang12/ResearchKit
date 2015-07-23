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
        
        //label width
        var width:Float = 90
        var distance:Float = (Float(self.frame.size.width)-(width*3))/4
        //var longDistance:Float = (Float(self.frame.size.width)-width)/2
        
            
        //  Minute counter label
        minCounterLabel = UILabel()
        minCounterLabel.frame = CGRectMake(10, 0, self.frame.size.width-20, 120)
        minCounterLabel.textColor = UIColor.blackColor()
        minCounterLabel.textAlignment = NSTextAlignment.Center
        minCounterLabel.text = "06:00"
        minCounterLabel.font = UIFont.boldSystemFontOfSize(100.0)
        self.addSubview(minCounterLabel)
        
        //add stepCountLabel
        stepCountLabel = UILabel()
        stepCountLabel.frame = CGRectMake(CGFloat(distance), 200, CGFloat(width), CGFloat(width))
        stepCountLabel.textColor = UIColor.blackColor()
        stepCountLabel.textAlignment = NSTextAlignment.Center
        stepCountLabel.text = "0 Steps"
        stepCountLabel.font = UIFont.systemFontOfSize(15)
        
        //round
        stepCountLabel.layer.cornerRadius = CGFloat(width/2)
        stepCountLabel.layer.borderWidth = 1
        
        self.addSubview(stepCountLabel)

        //add distance label
        distanceLabel = UILabel()
        distanceLabel.frame = CGRectMake(CGFloat(distance+width+distance), 200, CGFloat(width),CGFloat(width))
        distanceLabel.textColor = UIColor.blackColor()
        distanceLabel.textAlignment = NSTextAlignment.Center
        distanceLabel.text = "0 Feets"
        distanceLabel.font = UIFont.systemFontOfSize(15)
        
        //round
        distanceLabel.layer.cornerRadius = CGFloat(width/2)
        distanceLabel.layer.borderWidth = 1
        
        self.addSubview(distanceLabel)

        //  Add heart rate label
        heartRateLabel = UILabel()
        heartRateLabel.frame = CGRectMake(CGFloat(3*distance+2*width), 200, CGFloat(width), CGFloat(width))
        heartRateLabel.textColor = UIColor.blackColor()
        heartRateLabel.textAlignment = NSTextAlignment.Center
        heartRateLabel.text = "0 BPM"
        heartRateLabel.font = UIFont.systemFontOfSize(15)
        
        //round
        heartRateLabel.layer.cornerRadius = CGFloat(width/2)
        heartRateLabel.layer.borderWidth = 1
        
        self.addSubview(heartRateLabel)

    }
}