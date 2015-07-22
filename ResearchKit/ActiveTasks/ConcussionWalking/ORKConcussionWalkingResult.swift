//
//  ORKConcussionWalkingResult.swift
//  ResearchKit
//
//  Created by Arundev K S on 13/07/15.
//  Copyright (c) 2015 researchkit.org. All rights reserved.
//

import Foundation

public class ORKConcussionWalkingResult : ORKStepResult {
    var stepCount: Double = 0.0
    var distance: Double = 0.0
    var averageHeartRate: Double = 0.0
    var stepResults: [ORKResult] = [ORKResult]()
}