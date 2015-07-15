//
//  ORKConcussionWalkingStep.swift
//  ResearchKit
//
//  Created by Arundev K S on 13/07/15.
//  Copyright (c) 2015 researchkit.org. All rights reserved.
//

import Foundation
import ResearchKit.Private

/**
This is the class that defines the walk test Step
**/
public class ORKConcussionWalkingStep : ORKActiveStep {
    
    var activity: ORKConcussionWalkingActivity!
    
    //session containing step info
    var session: ORKConcussionWalkingSession!
    
    //initialization with ID and sequence
    init(identifier:String ,activity: ORKConcussionWalkingActivity)
    {
        super.init(identifier: identifier)
        self.activity = activity
        self.title = "Walk Test"
        self.shouldContinueOnFinish = false
        
        //create session
        self.session = ORKConcussionWalkingSession()
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
        return ORKConcussionWalkingStepViewController.classForCoder()
    }
    
    //copy with zone to copy the object
    override public func copyWithZone(zone: NSZone) -> AnyObject {
        var copy:ORKConcussionWalkingStep = super.copyWithZone(zone) as! ORKConcussionWalkingStep
        
        return copy
    }
    
    override public func validateParameters() {
        //validate the parameters passed to the step
    }

}