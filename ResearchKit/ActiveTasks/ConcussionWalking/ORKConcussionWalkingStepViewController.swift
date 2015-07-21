//
//  ORKConcussionWalkingStepViewController.swift
//  ResearchKit
//
//  Created by Arundev K S on 13/07/15.
//  Copyright (c) 2015 researchkit.org. All rights reserved.
//

import Foundation
import ResearchKit.Private
import HealthKit
import CoreMotion

public class ORKConcussionWalkingStepViewController: ORKActiveStepViewController, ORKPedometerRecorderDelegate {
    
    enum State : String {
        case Normal =   "normal"
        case High   =   "high"
        case Low    =   "low"
    }
    
    let sec : Double = 60
    let stdStepCountPerMin : Double = 50
    
    var contentView:ORKConcussionWalkingContentView!
    
    var pedometer = CMPedometer()
    
    var activity: ORKConcussionWalkingActivity = ORKConcussionWalkingActivity()
    
    //the concussion step result
    var concussionResult: ORKConcussionWalkingResult = ORKConcussionWalkingResult()
    
    var application: UIApplication = UIApplication.sharedApplication()
    var background_task: UIBackgroundTaskIdentifier!
    
    //timer instance used to load substeps
    var timer: NSTimer!
    
    var state: State = State.Normal
    
    var startDate: NSDate!
    var pedometerRecorder: ORKPedometerRecorder?
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init(step: ORKStep?) {
        super.init(step: step)
    }

    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        startDate = NSDate.new()
        self.contentView = (ORKConcussionWalkingContentView(frame: CGRectMake(0, 0, self.view.frame.size.width, 350)))
        self.customView = self.contentView
        
        self.startActivity()
        self.configureRecorder()
    }
    
    func configureRecorder() {
        var tempOutputDirectory = NSTemporaryDirectory().stringByAppendingPathComponent("recorderData")
        var url: NSURL = NSURL(fileURLWithPath: tempOutputDirectory)!
        pedometerRecorder = ORKPedometerRecorder(step: self.step!, outputDirectory: url)
        pedometerRecorder!.delegate = self
        pedometerRecorder!.start()
    }
    
    public func pedometerRecorderDidUpdate(pedometerRecorder: ORKPedometerRecorder) {
        let numberOfSteps: Double = Double(pedometerRecorder.totalNumberOfSteps)
        let distance: Double = Double(pedometerRecorder.totalDistance)
        self.concussionResult.stepCount = numberOfSteps
        self.concussionResult.distance = distance
        var interval = NSDate.new().timeIntervalSinceDate(self.startDate)/self.sec
        var stdStepCount = self.stdStepCountPerMin * interval
        
        if Int(stdStepCount-10) ... Int(stdStepCount+10) ~= Int(numberOfSteps) {
            if self.state != State.Normal {
                self.postNotificationWithMessage("You are walking at normal speed. Go ahead")
                self.state = State.Normal
            }
        } else if numberOfSteps < stdStepCount-10 {
            if self.state != State.Low {
                self.postNotificationWithMessage("You are walking too slow.")
                self.state = State.Low
            }
        } else if numberOfSteps > stdStepCount+10 {
            if self.state != State.High {
                self.postNotificationWithMessage("You are walking at a faster rate.")
                self.state = State.High
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.contentView.stepCountLabel.text = "\(numberOfSteps) Steps"
            let distanceValue = String(format: "%.2f Metres", distance)
            self.contentView.distanceLabel.text = distanceValue
        })
    }

    
    override public func recorder(recorder: ORKRecorder, didCompleteWithResult result: ORKResult?) {
        self.concussionResult.stepResults.append(result!)
    }
    
    override public func recorder(recorder: ORKRecorder, didFailWithError error: NSError) {
        let alertView : UIAlertController = UIAlertController(title: "Failed", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
        let defaultAction : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) -> Void in
            
        })
        alertView.addAction(defaultAction)
        self.presentViewController(alertView, animated: true, completion: nil)
    }
    
    //function to retrieve the result object
    override public var result : ORKStepResult {
            return self.concussionResult as ORKStepResult
            
    }
    
    //start actviity sequence
    private func startActivity() {
        //create timer to do the sequence display
        timer = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: Selector("timerFired"), userInfo: nil, repeats: true)
        
    }
    
    public func timerFired() {
        var interval: Int = Int(NSDate.new().timeIntervalSinceDate(startDate)/sec)
        var remainingTime: Int = 6 - interval
        
        if interval < 6 {
            self.postNotificationWithMessage("\(remainingTime) more minutes remaining.")
        } else {
            self.postNotificationWithMessage("You have completed your 6 minute task")
            timer.invalidate()
            pedometerRecorder?.stop()
            self.finish()
        }
    }
    
    public func postNotificationWithMessage(body: String) {
        let activeNotifications = UIApplication.sharedApplication().scheduledLocalNotifications
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        for notification in activeNotifications as! [UILocalNotification] {
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
        var localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertAction = "Walking activity messages"
        localNotification.alertTitle = "Walking Activity"
        localNotification.alertBody = body
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 0)
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
}
