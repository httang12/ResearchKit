//
//  ORKConcussionReverseMemoryStepViewController.swift
//  ResearchKit
//
//  Created by Huming Tang on 5/27/15.
//  Copyright (c) 2015 researchkit.org. All rights reserved.
//

import Foundation
//import ResearchKit.ResearchKit_Internal
import ResearchKit.Private



public class ORKConcussionReverseMemoryStepViewController: ORKActiveStepViewController
{
    
    var contentView:ORKConcussionReverseMemoryContentView!
    
    override init(step: ORKStep?) {
        super.init(step: step)
    }

    override public func viewDidLoad() {
        self.contentView = ORKConcussionReverseMemoryContentView()
        self.customView = contentView as UIView
        
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //start actviity sequence
    private func startActivity()
    {
        
    }
    
    //pause activity sequence
    private func pauseActivity(seconds:Int)
    {
        
    }
    
    //end activity sequence
    private func endActvity()
    {
        
    }
    
    //display the sequence num on the page
    private func showSequence(value:Int)
    {
        
    }
    
    //display keyboard entry to be captured
    private func showKeyBoardEntry()
    {
        
    }
    
    private func configureAppearance()
    {
        //configure title
        
        
        //configure description
        
        
        //configure numerical display tile
        
    }
    
}