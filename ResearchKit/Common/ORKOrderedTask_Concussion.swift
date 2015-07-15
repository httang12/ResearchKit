//
//  ORKOrderedTask_Concussion.swift
//  ResearchKit
//
//  Created by Huming Tang on 6/9/15.
//  Copyright (c) 2015 researchkit.org. All rights reserved.
//

import Foundation

public class ORKOrderedTask_Concusssion {
    
    public static func reverseNumericMemorySpanTest(identifier: String, sequenceCount: Int, sequenceStartLength: Int, retriesPerTest: Int) -> ORKOrderedTask {
        
        var steps = NSMutableArray()
        var instruction: ORKInstructionStep = ORKInstructionStep(identifier: "instructions")
        instruction.title = "Reverse Numeric Memory Span Test"
        instruction.detailText = "Put Active Task Detail Instructions Here."
        
        steps.addObject(instruction)
        
        var activity: ORKConcussionReverseMemoryActivity = ORKConcussionReverseMemoryActivity(exerciseCount: sequenceCount)
        
        var reverseMemoryStep: ORKConcussionReverseMemoryStep = ORKConcussionReverseMemoryStep(identifier: identifier, activity: activity)
        
        steps.addObject(reverseMemoryStep)
        
        var reverseNumerciMemoryTest: ORKOrderedTask = ORKOrderedTask(identifier: identifier, steps: steps as [AnyObject])
        
        return reverseNumerciMemoryTest
    }

    public static func walkTest(identifier: String, duration: Int) -> ORKOrderedTask {
        
        var steps = NSMutableArray()
        var instruction: ORKInstructionStep = ORKInstructionStep(identifier: "instructions")
        instruction.title = "\(duration) minute walk Test"
        instruction.detailText = "This activity monitors your heart rate and measures how far you can walk in \(duration) minutes"
        
        steps.addObject(instruction)
        
        var activity: ORKConcussionWalkingActivity = ORKConcussionWalkingActivity()

        var walkingStep: ORKConcussionWalkingStep = ORKConcussionWalkingStep(identifier: identifier, activity: activity)
        walkingStep.stepDuration = NSTimeInterval(duration * 60)
        steps.addObject(walkingStep)
        
        var walkTest: ORKOrderedTask = ORKOrderedTask(identifier: identifier, steps: steps as [AnyObject])
        
        return walkTest
    }
}