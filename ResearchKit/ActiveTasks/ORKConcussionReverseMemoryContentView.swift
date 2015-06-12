//
//  ORKConcussionReverseMemoryContentView.swift
//  ResearchKit
//
//  Created by Huming Tang on 5/29/15.
//  Copyright (c) 2015 researchkit.org. All rights reserved.
//

import Foundation
import UIKit
import ResearchKit.Private

public class ORKConcussionReverseMemoryContentView : UIView 
{
    var title: UILabel!
    var description_top: UILabel!
    var description_bottom: UILabel!
    var sequenceDisplay: UILabel!
    var actionButton: UIButton!
    var inputField: UITextField!
    
    var textColor: UIColor = UIColor.whiteColor()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }

    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //configure UI Elements
    private func configureUI()
    {
        /*
        //add title label
        title = UILabel()
        title.frame = CGRectMake(10, 10, 300, 75)
  
        title.textColor = UIColor.whiteColor()
        title.textAlignment = NSTextAlignment.Center
        title.text = "Digit Span Memory Test"
        title.font = UIFont.boldSystemFontOfSize(18.0)
        self.addSubview(title)
        */
        
        //add description top under title label
        description_top = UILabel()
        description_top.frame = CGRectMake(20, 80, 330, 100)

        
        description_top.textAlignment = NSTextAlignment.Center
  
        description_top.lineBreakMode = NSLineBreakMode.ByWordWrapping
         description_top.font = UIFont.systemFontOfSize(30.0)
        description_top.numberOfLines = 0
        description_top.hidden = true
        self.addSubview(description_top)
        
        //add sequence display
        sequenceDisplay = UILabel()
        sequenceDisplay.frame = CGRectMake(20, 0, 330, 330)
        
        
        sequenceDisplay.lineBreakMode = NSLineBreakMode.ByWordWrapping
        sequenceDisplay.numberOfLines = 0
        
        sequenceDisplay.textColor = UIColor.whiteColor()
        sequenceDisplay.textAlignment = NSTextAlignment.Center
        sequenceDisplay.text = ""
        sequenceDisplay.layer.cornerRadius = 8
        sequenceDisplay.textColor = self.textColor
        sequenceDisplay.layer.borderColor = UIColor.grayColor().CGColor
        sequenceDisplay.layer.borderWidth = 1.0
        sequenceDisplay.font = UIFont.systemFontOfSize(120.0)
        self.addSubview(sequenceDisplay)
        
        inputField = ORKConcussionReverseMemoryTextField()
        
        //inputField.delegate = ORKConcussionReverseMemoryTextFieldDelegate()
        //inputField = UITextField()
        inputField.frame = CGRectMake(20, 50, 330, 150)
        inputField.keyboardType = UIKeyboardType.NumberPad
        inputField.font = UIFont.systemFontOfSize(80.0)
        inputField.layer.borderColor = UIColor.grayColor().CGColor
        inputField.layer.borderWidth = 1.0
        inputField.textAlignment = NSTextAlignment.Center
        inputField.layer.cornerRadius = 8
        self.addSubview(inputField)
        
        inputField.hidden=true
        inputField.selectedTextRange = nil
        //setup toolbar for key action
        
        /*
        //add description bottom under sequence display
        description_bottom = UILabel()
        description_bottom.frame = CGRectMake(10, 400, 300, 75)
        
        description_bottom.textColor = UIColor.whiteColor()
        description_bottom.textAlignment = NSTextAlignment.Center
        description_bottom.text = "Retries: 0"
        description_top.lineBreakMode = NSLineBreakMode.ByWordWrapping
        description_top.numberOfLines = 0
        self.addSubview(description_bottom)
        */
        
        /*
        actionButton = UIButton()
        actionButton.frame = CGRectMake(10, 500, 200, 50)
        actionButton.setTitle("Start", forState: .Normal)
        actionButton.layer.cornerRadius = 8
        actionButton.layer.borderColor = UIColor.blueColor().CGColor
        actionButton.layer.borderWidth = 1.0
        actionButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        actionButton.setTitleColor(UIColor.whiteColor(), forState: .Selected )

       
        
        self.addSubview(actionButton)
        */
        
    }
    //set the number display
    func setSequenceDisplayContent(text:String)
    {
        self.sequenceDisplay.text = text
    }
    
    //set the number display
    func updateDisplayNum(number: String)
    {

        self.sequenceDisplay.text = number
    }
    
    override public func canBecomeFirstResponder() -> Bool {
        return true
    }
    
}