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
    var stepCountLabel: UILabel!
    var distanceLabel: UILabel!
    
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
        title.frame = CGRectMake(10, 10, self.frame.size.width-20, 75)
        title.textColor = UIColor.blackColor()
        title.textAlignment = NSTextAlignment.Center
        title.text = "Concussion walking test"
        title.font = UIFont.boldSystemFontOfSize(20.0)
        self.addSubview(title)
        
        //add stepCountLabel
        stepCountLabel = UILabel()
        stepCountLabel.frame = CGRectMake(10, 100, self.frame.size.width-20, 75)
        stepCountLabel.textColor = UIColor.blackColor()
        stepCountLabel.textAlignment = NSTextAlignment.Center
        stepCountLabel.text = "0 Steps"
        stepCountLabel.font = UIFont.boldSystemFontOfSize(22.0)
        self.addSubview(stepCountLabel)

        //add distance label
        distanceLabel = UILabel()
        distanceLabel.frame = CGRectMake(10, 200, self.frame.size.width-20, 75)
        distanceLabel.textColor = UIColor.blackColor()
        distanceLabel.textAlignment = NSTextAlignment.Center
        distanceLabel.text = "0 Metres"
        distanceLabel.font = UIFont.boldSystemFontOfSize(22.0)
        self.addSubview(distanceLabel)

    }
}