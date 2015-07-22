//
//  ORKConcussionWalkingCompletionStep.swift
//  ResearchKit
//
//  Created by Arundev K S on 21/07/15.
//  Copyright (c) 2015 researchkit.org. All rights reserved.
//

import Foundation
import ResearchKit.Private

/**
This is the class that defines the walk test completion Step
**/
public class ORKConcussionWalkingCompletionStep : ORKActiveStep {
    
    var stepCount: Double = 0.0
    var distance: Double = 0.0
    var heartRate: Double = 0.0
    
    //initialization with ID and sequence
    override init(identifier:String) {
        super.init(identifier: identifier)
        self.title = "Walk Exercise Completed"
        self.shouldContinueOnFinish = false
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
        return ORKConcussionWalkingCompletionViewController.classForCoder()
    }
    
    //copy with zone to copy the object
    override public func copyWithZone(zone: NSZone) -> AnyObject {
        var copy:ORKConcussionWalkingCompletionStep = super.copyWithZone(zone) as! ORKConcussionWalkingCompletionStep
        
        return copy
    }
    
    override public func validateParameters() {
        //validate the parameters passed to the step
    }
    
}