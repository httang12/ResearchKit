//
//  ORKConcussionWalkingActivity.swift
//  ResearchKit
//
//  Created by Arundev K S on 13/07/15.
//  Copyright (c) 2015 researchkit.org. All rights reserved.
//

import Foundation
import CoreMotion

public class ORKConcussionWalkingActivity : NSObject {
    
    var healthStore: HKHealthStore!
    var startDate: NSDate!
    var endDate: NSDate!

    
    override init() {
        self.healthStore = HKHealthStore()
    }
    
    func readRecentSamples(sampleType:HKSampleType , completion: (([HKQuantitySample]!, NSError!) -> Void)!) {
        
        // Building the Predicate
        let now   = NSDate()
        let mostRecentPredicate = HKQuery.predicateForSamplesWithStartDate(startDate, endDate:endDate, options: .None)
        
        // Building the sort descriptor to return the samples in descending order
        let sortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: false)
        
        // Building samples query
        let sampleQuery = HKSampleQuery(sampleType: sampleType, predicate: mostRecentPredicate, limit:Int(HKObjectQueryNoLimit), sortDescriptors: [sortDescriptor])
            { (sampleQuery, results, error ) -> Void in
                
                if let queryError = error {
                    completion(nil,error)
                    return;
                }
                
                // Execute the completion closure
                if completion != nil {
                    completion(results as? [HKQuantitySample],nil)
                }
        }
        //  Execute the Query
        self.healthStore.executeQuery(sampleQuery)
    }
    
    public func getHeartRate(startDate: NSDate, endDate: NSDate, heartRateResults:((Double , NSError!) -> Void)) {
        
        self.startDate = startDate
        self.endDate = endDate
        
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
                    heartRateResults(0.0,error)
                } else {
                    //  Construct an HKSampleType for Step count
                    let sampleType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)
                    //  Call the method to read the most recent weight sample
                    self.readRecentSamples(sampleType, completion: { (results, error) -> Void in
                        if (error != nil) {
                            println("An error has occured with the following description: \(error?.localizedDescription)")
                            heartRateResults(0.0,error)
                        } else {
                            var totalSteps: Double = 0
                            for sam: HKQuantitySample in results {
                                var quantity : HKQuantity = sam.quantity
                                var count : Double = quantity.doubleValueForUnit(HKUnit.countUnit()) as Double
                                totalSteps = totalSteps + count
                                println("Step count is \(quantity.doubleValueForUnit(HKUnit.countUnit()))")
                            }
                            heartRateResults(totalSteps , nil)
                        }
                    });
                }
            })
        }
    }

}