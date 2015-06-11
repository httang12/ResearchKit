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
    var sequenceIndex: Int = 0
    var currentState: String = ""
    var currentSequenceNumberIndex: Int = 0
    var tmpStop: Bool = false
    
    var timer: NSTimer!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init(step: ORKStep?) {
        super.init(step: step)
    }

    override public func viewDidLoad() {
        NSLog("append view...")
        super.viewDidLoad()
        self.contentView = (ORKConcussionReverseMemoryContentView(frame: CGRectMake(0, 0, 500, 350)))

        self.customView = self.contentView
        self.startActivity()
        
        /*
        self.contentView = ORKConcussionReverseMemoryContentView(frame: CGRectMake(0, 0, 500, 750))
        self.contentView = contentView as UIView
        self.view = self.contentView
        
        //register button on view with action
        //add action
        self.contentView.actionButton.addTarget(self, action: "actionButtonPressed:", forControlEvents: .TouchUpInside)
        */
    }
    
    //handle button action
    func actionButtonPressed(sender: UIButton!)
    {
        //should react base on the state of the activity
        
        //case 1, start activity
        self.startActivity()
    }
    
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func start() {
        super.start()
        self.startActivity()
    }
    
    override public func finish() {
        super.finish()
        self.suspend()
    }
    
    override public func suspend() {
        super.suspend()
        self.pauseActivity()
    }
    
    override public func resume() {
        super.resume()
    }
    
    
    
    //start actviity sequence
    private func startActivity()
    {
        
        //create timer to do the sequence display
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateSequenceDisplay"), userInfo: nil, repeats: true)
       
    }
    
    func updateSequenceDisplay()
    {
        //get the sequence from game config
        let step = self.step as! ORKConcussionReverseMemoryStep
        let activity = step.activity
        let sequence = activity.memorySequence[sequenceIndex]
        let numsToDisplay = sequence.sequence

        
        if (self.tmpStop)
        {
            self.contentView.setSequenceDisplayContent("")
            tmpStop = false
        }
        else if(currentSequenceNumberIndex < numsToDisplay.count)
        {
            self.contentView.updateDisplayNum(numsToDisplay[currentSequenceNumberIndex])
            self.tmpStop = true
            currentSequenceNumberIndex = currentSequenceNumberIndex+1
        }
        else
        {
            if let displayTimer = self.timer
            {
                displayTimer.invalidate()
                //show keyboard
                self.contentView.inputField.hidden=false
                self.contentView.inputField.becomeFirstResponder()
                self.contentView.sequenceDisplay.hidden=true
            }
        }
    
    }

    //pause activity sequence
    private func pauseActivity()
    {
        //refresh sequence, display  message
    }
    
    //end activity sequence
    private func endActvity()
    {
        //display result message
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