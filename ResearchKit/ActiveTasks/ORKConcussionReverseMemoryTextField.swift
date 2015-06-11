//
//  ORKConcussionReverseMemoryTextField.swift
//  ResearchKit
//
//  Created by Huming Tang on 6/11/15.
//  Copyright (c) 2015 researchkit.org. All rights reserved.
//

import Foundation
import UIKit

public class ORKConcussionReverseMemoryTextField : UITextField
{
    override public func caretRectForPosition(position: UITextPosition!) -> CGRect {
        return CGRect.zeroRect
    }
}