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
    
    //the concussion step result
    var concussionResult: ORKConcussionReverseMemoryResult = ORKConcussionReverseMemoryResult()
    
    //timer instance used to load substeps
    var timer: NSTimer!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init(step: ORKStep?) {
        super.init(step: step)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.contentView = (ORKConcussionReverseMemoryContentView(frame: CGRectMake(0, 0, 500, 350)))

        self.customView = self.contentView
         NSLog("start position:" + self.view.center.x.description + "-" + self.view.center.y.description)
        
        self.contentView.inputField.addTarget(self, action: "inputValueChanged", forControlEvents: UIControlEvents.EditingChanged)
        
        //remove the parent gesture recognizer... they are not needed
        var allViews = self.view.subviews as! [UIView]
        
        for subview: UIView in allViews {
       
            if let recognizers = subview.gestureRecognizers {
                for recognizer in recognizers {
                    subview.removeGestureRecognizer(recognizer as! UIGestureRecognizer)
                }
            }
        }
        //set appearance
        self.configureAppearance()
        
        self.startActivity()
        
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
    
    func proceedToNextActivity()
    {
        //break out if all sequences are done
        let step = self.step as! ORKConcussionReverseMemoryStep
        let activity = step.activity
        if (self.sequenceIndex >= activity.sequenceCount - 1)
        {
            self.endActvity()
        }
        else
        {
            self.sequenceIndex += 1
            //reset interface and prep for new activity
            self.prepareInterfaceForActivity()
            self.startActivity()
        }
    }
    
    func retryCurrentActivity()
    {
        //reset interface and prep for new activity
        //break out if all sequences are done
        let step = self.step as! ORKConcussionReverseMemoryStep
        let activity = step.activity
        activity.resetSequence()
        
        self.prepareInterfaceForActivity()
        self.startActivity()
    }
    
    private func prepareInterfaceForActivity()
    {
        self.contentView.inputField.text = ""
        self.contentView.sequenceDisplay.text = ""
        self.contentView.sequenceDisplay.hidden = false
        self.contentView.description_top.hidden = true
        self.currentSequenceNumberIndex = 0
        self.view.frame.size = CGSize(width:self.view.frame.size.width, height: self.view.frame.size.height + 100.0)
    }
    
    func updateSequenceDisplay()
    {
        self.contentView.description_top.hidden = true
        
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
                self.showKeyBoardEntry()
            }
        }
    }

    //pause activity sequence
    private func pauseActivity()
    {
        //refresh sequence, display message
    }
    
    //end activity sequence
    private func endActvity()
    {
        self.finish()
    }
    
    //display the sequence num on the page
    private func showSequence(value:Int)
    {
        
    }
    
    //display keyboard entry to be captured
    private func showKeyBoardEntry()
    {
        //show key board
        self.contentView.inputField.becomeFirstResponder()
        
    }
    
    private func configureAppearance()
    {
        self.view.backgroundColor = UIColor.blackColor()
        
        self.setViewColor(self.view)
        

    }
    
    //recursive function to set colors
    func setViewColor(view:UIView)
    {
        NSLog("Recursive View Update!")
        
        if (view.isKindOfClass(UILabel))
        {
            var label: UILabel = view as! UILabel
            
            label.textColor = UIColor.whiteColor()
            label.tintColor = UIColor.whiteColor()

            return
        }
        
        if let subviews: [UIView] = view.subviews as? [UIView]
        {
            for subview: UIView in subviews
            {
                self.setViewColor(subview)
            }
        }
    }
    
    //action performed when the numeric input field changed
    func inputValueChanged()
    {
        //get the sequence from game config
        let step = self.step as! ORKConcussionReverseMemoryStep
        let activity = step.activity
        
        self.contentView.sequenceDisplay.text = self.contentView.inputField.text
        
        var joinString = ""
        
        var inputString = self.contentView.inputField.text
        let reverseSequenceString = joinString.join(activity.memorySequence[sequenceIndex].sequence.reverse())
        
        if (count(inputString) == count(reverseSequenceString))
        {
            self.contentView.endEditing(true)
            
            var validated = self.validateString(inputString,reverseSequenceString: reverseSequenceString)
            if (!validated)
            {
                self.showMessage("Incorrect entry, please try again.", color: UIColor.redColor())
                
                timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("retryCurrentActivity"), userInfo: nil, repeats: false)
                
            }
            else
            {
                self.showMessage("You entered the correct sequence.", color: UIColor.greenColor())
                    
                timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("proceedToNextActivity"), userInfo: nil, repeats: false)
            }
        }
    }
    
    func validateString(value: String, reverseSequenceString: String) -> Bool
    {
        if (reverseSequenceString == value)
        {
            return true
        }
        
        return false
    }
    
    private func showMessage(message: String, color: UIColor)
    {
        self.contentView.description_top.hidden = false
        self.contentView.sequenceDisplay.hidden = true
        
        self.contentView.description_top.text = message
        self.contentView.description_top.textColor = color

    }
    
    private func updateResult()
    {
        //get the sequence from game config
        let step = self.step as! ORKConcussionReverseMemoryStep
        let activity = step.activity
        
        //maybe store this in the controller
        var joinString = ""
        
        var inputString = self.contentView.inputField.text
        let sequenceString = joinString.join(activity.memorySequence[sequenceIndex].sequence)

        
        //add a new result entry
        var subResult = ORKConcussionReverseMemorySubStepResult()
        subResult.answer = self.contentView.inputField.text
        subResult.sequence = sequenceString
        
        self.concussionResult.subStepResults.append(subResult)
        
    }
    
    
    //function to retrieve the result object
    override public var result : ORKStepResult
    {
        return self.concussionResult as ORKStepResult
        
    }
    
}