//
//  ORKConcussionReverseMemoryActivity.swift
//  ResearchKit
//
//  Created by Huming Tang on 5/27/15.
//  Copyright (c) 2015 nyulangone.org. All rights reserved.
//

import Foundation

//This is the class that holds all the logic/properties for the reverse memory exerise
public class ORKConcussionReverseMemoryActivity : NSObject
{
    //number of seconds to delay between each numeric display
    var activityTime: Int = 1
    
    //name of this activity
    var activityTitle: String!
    
    //id of this activity
    var activityID: String!
    
    //description of this activity
    var activityDesc: String!
    
    //memory holder
    var memorySequence: [ORKConcussionReverseMemorySequence] = [ORKConcussionReverseMemorySequence]()
    
    var sequenceCount: Int = 0
    
    
    //class initialization
    init(exerciseCount:Int)
    {
        super.init()
        self.sequenceCount = exerciseCount
        self.populateSequence()
    }
    
    func resetSequence()
    {
        memorySequence.removeAll(keepCapacity: false);
        self.populateSequence()
    }
    
    private func populateSequence()
    {
        for index in 1 ... sequenceCount
        {
            memorySequence.append(ORKConcussionReverseMemorySequence(size: index+2))
        }
    }
    
}