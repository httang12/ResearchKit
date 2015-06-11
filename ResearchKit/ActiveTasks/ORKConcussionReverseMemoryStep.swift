//
//  ORKConcussionReverseMemoryStep.swift
//  ResearchKit
//
//  Created by Huming Tang on 5/27/15.
//  Copyright (c) 2015 researchkit.org. All rights reserved.
//

import Foundation
import ResearchKit.Private

public class ORKConcussionReverseMemoryStep : ORKActiveStep
{
    //current number of retries
    var retries: Int = 0
    
    //sequence associated with the step
    var activity: ORKConcussionReverseMemoryActivity!
    
    //initialization with ID and sequence
    init(identifier:String ,activity: ORKConcussionReverseMemoryActivity)
    {
        super.init(identifier: identifier)
        self.activity = activity
        self.title = "Watch the sequence of number on screen."
        self.stepDuration = 30.0
        self.shouldContinueOnFinish = true
    }

    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func encodeWithCoder(aCoder: NSCoder) {
        //put property encoding here
    }
    
    static func stepViewControllerClass() -> AnyClass
    {
        return ORKConcussionReverseMemoryStepViewController.classForCoder()
    }
    
    override public func copyWithZone(zone: NSZone) -> AnyObject {
        var copy:ORKConcussionReverseMemoryStep = super.copyWithZone(zone) as! ORKConcussionReverseMemoryStep
        copy.retries = self.retries
        
        return copy
    }
    
    override public func validateParameters() {
        //validate the parameters passed to the step
    }
}