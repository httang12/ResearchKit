//
//  ORKConcussionReverseMemorySession.swift
//  ResearchKit
//
//  Created by Huming Tang on 6/12/15.
//  Copyright (c) 2015 researchkit.org. All rights reserved.
//

import Foundation

//defines a session of activity, stores all the temporary object needed during a session
public class ORKConcussionReverseMemorySession
{
    var currentSequenceString: String!
    var activityConfig: ORKConcussionReverseMemoryActivity!
    var currentSequenceIndex: Int = 0
    var paused: Bool = false
    var currentTries: Int = 0
    
}