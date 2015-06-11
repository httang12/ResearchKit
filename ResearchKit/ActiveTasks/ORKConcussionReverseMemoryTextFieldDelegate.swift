//
//  ORKConcussionReverseMemoryTextFieldDelegate.swift
//  ResearchKit
//
//  Created by Huming Tang on 6/11/15.
//  Copyright (c) 2015 researchkit.org. All rights reserved.
//

import Foundation

public class ORKConcussionReverseMemoryTextFieldDelegate: NSObject, UITextFieldDelegate
{
    var canRemove: Bool = false
    
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        return canRemove
    }
}