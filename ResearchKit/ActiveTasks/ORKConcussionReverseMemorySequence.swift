//
//  ORKConcussionReverseMemorySequence.swift
//  ResearchKit
//
//  Created by Huming Tang on 5/27/15.
//  Copyright (c) 2015 researchkit.org. All rights reserved.
//

import Foundation

//object holding a sequence for reverse memory process
public class ORKConcussionReverseMemorySequence : NSObject
{
    //array holds the sequence values
    var sequence: [String] = [String]()
    
    init(size:Int)
    {
        super.init()
        self.generateRandomSequence(size)
    }
    
    private func generateRandomSequence(size:Int)
    {
        //quick for loop
        for index in 1 ... size
        {
            sequence.append(NSInteger(arc4random_uniform(10)).description)
        }
    }
}