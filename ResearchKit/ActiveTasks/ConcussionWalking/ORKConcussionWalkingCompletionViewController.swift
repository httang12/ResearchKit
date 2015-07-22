//
//  ORKConcussionWalkingCompletionViewController.swift
//  ResearchKit
//
//  Created by Arundev K S on 21/07/15.
//  Copyright (c) 2015 researchkit.org. All rights reserved.
//

import Foundation
import ResearchKit.Private

public class ORKConcussionWalkingCompletionViewController: ORKActiveStepViewController {

    var contentView:ORKConcussionWalkingCompletionContentView?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init(step: ORKStep?) {
        super.init(step: step)
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.contentView = (ORKConcussionWalkingCompletionContentView(frame: CGRectMake(0, 0, self.view.frame.size.width, 350)))
        self.customView = self.contentView
        
        var completionStep: ORKConcussionWalkingCompletionStep = self.step as! ORKConcussionWalkingCompletionStep
        self.contentView?.stepCountLabel.text = "Total : \(completionStep.stepCount) steps"
        self.contentView?.distanceLabel.text = "Distance : \(completionStep.distance) feets"
        self.contentView?.heartRateLabel.text = "Average heart rate : \(completionStep.heartRate) BPM"
    }
    
}