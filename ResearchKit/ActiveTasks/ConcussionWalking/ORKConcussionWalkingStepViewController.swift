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
    let feetConvFactor: Double = 3.28084
    
    var contentView:ORKConcussionWalkingContentView!
    
    var pedometer = CMPedometer()
    var healthStore: HKHealthStore = HKHealthStore()
    var observeQuery: HKObserverQuery!
    
    var activity: ORKConcussionWalkingActivity = ORKConcussionWalkingActivity()
    
    //the concussion step result
    var concussionResult: ORKConcussionWalkingResult = ORKConcussionWalkingResult()
    
    var application: UIApplication = UIApplication.sharedApplication()
    var background_task: UIBackgroundTaskIdentifier!
    
    //timer instance used to load substeps
    var timer: NSTimer!
    
    var remTimer: NSTimer!
    
    var state: State = State.Normal
    
    var startDate: NSDate!
    var pedometerRecorder: ORKPedometerRecorder?
    
    var secondsLeft: Int = 360
    
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
        self.startObservingForHeartRateSamples()
        
        remTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
    }
    
    func updateCounter() {
        var spentTime = Int(NSDate.new().timeIntervalSinceDate(startDate))
        var remTime = secondsLeft - spentTime
        if(remTime > 0) {
            var minute = remTime/60
            var seconds = String(format: "%02d", remTime % 60)
            self.contentView.minCounterLabel.text = "\(minute):\(seconds)"
        } else {
            self.contentView.minCounterLabel.text = "00:00"
            remTimer.invalidate()
        }
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
        let distance: Double = Double(pedometerRecorder.totalDistance) * feetConvFactor
        self.concussionResult.stepCount = numberOfSteps
        self.concussionResult.distance = distance
        
        //  Updating completion step
        var currentStep: ORKConcussionWalkingStep = self.step as! ORKConcussionWalkingStep
        var completionStep: ORKConcussionWalkingCompletionStep = currentStep.completionStep
        completionStep.stepCount = numberOfSteps
        completionStep.distance = distance

        var interval = NSDate.new().timeIntervalSinceDate(self.startDate)/self.sec
        var stdStepCount = self.stdStepCountPerMin * interval
        
        if Int(stdStepCount-10) ... Int(stdStepCount+10) ~= Int(numberOfSteps) {
            if self.state != State.Normal {
                self.postNotificationWithMessage("Normal speed")
                self.state = State.Normal
            }
        } else if numberOfSteps < stdStepCount-10 {
            if self.state != State.Low {
                self.postNotificationWithMessage("Walk Faster")
                self.state = State.Low
            }
        } else if numberOfSteps > stdStepCount+10 {
            if self.state != State.High {
                self.postNotificationWithMessage("Slow Down")
                self.state = State.High
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.contentView.stepCountLabel.text = "\(numberOfSteps) Steps"
            let distanceValue = String(format: "%.2f Feets", distance)
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
        
        var currentStep: ORKConcussionWalkingStep = self.step as! ORKConcussionWalkingStep
        var completionStep: ORKConcussionWalkingCompletionStep = currentStep.completionStep
        completionStep.stepCount = self.concussionResult.stepCount
        completionStep.distance = self.concussionResult.distance
        
        if interval < 6 {
            self.postNotificationWithMessage("\(remainingTime) mins left.")
        } else {
            self.postNotificationWithMessage("Completed")
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
        localNotification.alertTitle = body
        localNotification.alertBody = body
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 0)
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    func startObservingForHeartRateSamples() {
        println("startObservingForHeartRateSamples")
        
        if HKHealthStore.isHealthDataAvailable() {
            let healthKitTypesToRead = Set(arrayLiteral: HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate),
                HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount),
                HKObjectType.workoutType()
            )
            
            let healthKitTypesToWrite = Set(arrayLiteral:
                HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDistanceWalkingRunning),
                HKQuantityType.workoutType()
            )
            
            self.healthStore.requestAuthorizationToShareTypes(healthKitTypesToWrite, readTypes: healthKitTypesToRead, completion: { (success: Bool, error: NSError!) -> Void in
                if !success {
                    println("You didn't allow HealthKit to access these read/write data types. In your app, try to handle this error gracefully when a user decides not to provide access. The error was: \(error.localizedDescription). If you're using a simulator, try it on a device.")
                } else {
                    let sampleType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)
                    
                    if self.observeQuery != nil {
                        self.healthStore.stopQuery(self.observeQuery)
                    }
                    
                    self.observeQuery = HKObserverQuery(sampleType: sampleType, predicate: nil) {
                        (query, completionHandler, error) in
                        
                        if error != nil {
                            println("An error has occured with the following description: \(error.localizedDescription)")
                        } else {
                            self.readRecentSamples(sampleType)
                        }
                    }
                    self.healthStore.executeQuery(self.observeQuery)
                }
            })
        }
    }
    
    func retrieveMostRecentHeartRateSample(completionHandler: (sample: HKQuantitySample) -> Void) {
        let sampleType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)
        let predicate = HKQuery.predicateForSamplesWithStartDate(NSDate.distantPast() as! NSDate, endDate: NSDate(), options: HKQueryOptions.None)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: 1, sortDescriptors: [sortDescriptor])
            { (query, results, error) in
                if error != nil {
                    println("An error has occured with the following description: \(error.localizedDescription)")
                } else {
                    let mostRecentSample = results[0] as! HKQuantitySample
                    completionHandler(sample: mostRecentSample)
                }
        }
        healthStore.executeQuery(query)
    }
    
    func readRecentSamples(sampleType:HKSampleType) {
        
        // Building the Predicate
        let now   = NSDate()
        let mostRecentPredicate = HKQuery.predicateForSamplesWithStartDate(startDate, endDate:NSDate.new(), options: .None)
        
        // Building the sort descriptor to return the samples in descending order
        let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: false)
        
        // Building samples query
        let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate: mostRecentPredicate, limit:Int(HKObjectQueryNoLimit), sortDescriptors: [sortDescriptor]) { (sampleQuery, results, error ) -> Void in
                
                // Execute the completion closure
                var totalCount: Double = 0
                for sam in results as! [HKQuantitySample] {
                    var quantity : HKQuantity = sam.quantity
                    let count = quantity.doubleValueForUnit(HKUnit(fromString: "count/min"))
                    totalCount = totalCount + count
                }
            var currentStep: ORKConcussionWalkingStep = self.step as! ORKConcussionWalkingStep
            var completionStep: ORKConcussionWalkingCompletionStep = currentStep.completionStep
            completionStep.heartRate = totalCount / Double(results.count)
            self.concussionResult.averageHeartRate = totalCount / Double(results.count)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.contentView.heartRateLabel.text = "\(totalCount / Double(results.count)) BPM"
            })

        }
        //  Execute the Query
        self.healthStore.executeQuery(sampleQuery)
    }

}
