//
//  ORKConcussionReverseMemoryStep.swift
//  ResearchKit
//
//  Created by Huming Tang on 5/27/15.
//  Copyright (c) 2015 researchkit.org. All rights reserved.
//

import Foundation
import ResearchKit.Private

/**
This is the class that defines the Reverse Memory Active Task Step
**/
public class ORKConcussionReverseMemoryStep : ORKActiveStep
{
    
    //sequence associated with the step
    var activity: ORKConcussionReverseMemoryActivity!
    
    //session containing step info
    var session: ORKConcussionReverseMemorySession!
    
    //initialization with ID and sequence
    init(identifier:String ,activity: ORKConcussionReverseMemoryActivity)
    {
        super.init(identifier: identifier)
        self.activity = activity
        self.title = "Watch the sequence of number on screen."
        self.stepDuration = 30.0
        self.shouldContinueOnFinish = true
        
        //create session
        self.session = ORKConcussionReverseMemorySession()
    }
    
    //constructor for NSCoder
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //defines property encoding so serialization can happen
    override public func encodeWithCoder(aCoder: NSCoder) {
        //put property encoding here
    }
    
    //return the class type of the underlying view controller
    static func stepViewControllerClass() -> AnyClass
    {
        return ORKConcussionReverseMemoryStepViewController.classForCoder()
    }
    
    //copy with zone to copy the object
    override public func copyWithZone(zone: NSZone) -> AnyObject {
        var copy:ORKConcussionReverseMemoryStep = super.copyWithZone(zone) as! ORKConcussionReverseMemoryStep
        
        return copy
    }
    
    override public func validateParameters() {
        //validate the parameters passed to the step
    }
}