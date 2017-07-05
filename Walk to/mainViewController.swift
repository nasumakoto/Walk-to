//
//  mainViewController.swift
//  Walk to
//
//  Created by 那須真 on 2017/06/27.
//  Copyright © 2017年 Makoto Nasu. All rights reserved.
//

import Foundation
import UIKit
import HealthKit

class mainViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var myDate: UILabel!
    
    @IBOutlet weak var stepCountLabel: UILabel!
    
    @IBOutlet weak var myDays: UILabel!
    
    @IBOutlet weak var totalProgress: UIProgressView!
    
    @IBOutlet weak var nextDistance: UILabel!
    
    var timer = Timer()
    
    let healthKitStore = HKHealthStore()
    
    let now = Date()
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        
        let jaLocale = Locale(identifier: "ja_JP")
        
        let df = DateFormatter()
        df.dateFormat = "yyyy年MM月dd日"
        myDate.text = df.string(from: now)
        
        let calendar = Calendar.current
        let dateFrom = calendar.date(from: DateComponents(year: 2017, month: 7, day: 1))!
        var comps: DateComponents
        
        comps = calendar.dateComponents([.day], from: dateFrom, to: now)
        myDays.text = String(comps.day!)
        print(comps.day!) // 14012

        
    }

    // 画面が表示されるたびに毎回発動
    override func viewWillAppear(_ animated: Bool) {
        
        timer = Timer.scheduledTimer(timeInterval: 0.00, target: self, selector: #selector(mainViewController.go), userInfo: nil, repeats: true)
        
        if(checkAuthorization())
        {
            if(HKHealthStore.isHealthDataAvailable())
            {
                recentSteps() { steps, error in
                    DispatchQueue.main.async {
                        self.stepCountLabel.text = String(format:"%.0f", steps)
                    }
                }
                
            }
        }
        
    }

    
    
    func go () {
        
        totalProgress.progress = 0.000005
        totalProgress.setProgress(1.0, animated: true)
        totalProgress.transform = CGAffineTransform(scaleX: 1.0, y: 7.0)
    
    }
    
    
    
    func updateStepCount()
    {
        
    }
    
    func checkAuthorization() -> Bool
    {
        var isEnabled = true
        
        if HKHealthStore.isHealthDataAvailable()
        {
            let healthKitTypesToRead : Set = [
                HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.dateOfBirth)!,
                HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.bloodType)!,
                HKObjectType.characteristicType(forIdentifier: HKCharacteristicTypeIdentifier.biologicalSex)!,
                HKObjectType.quantityType(forIdentifier:HKQuantityTypeIdentifier.stepCount)!,
                HKObjectType.workoutType(),
                HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!
            ]
            
            healthKitStore.requestAuthorization(toShare: nil, read: healthKitTypesToRead, completion: { (success, error) in
                isEnabled = success
            })
        }
        else
        {
            isEnabled = false
        }
        
        return isEnabled
    }
    
    func recentSteps(completion: @escaping (Double, NSError?) -> () )
    {
        let healthKitTypesToRead = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)
        
        
        let calendar = Calendar.current
        let dateFrom = calendar.date(from: DateComponents(year: 2017, month: 7, day: 1))!
        var comps: DateComponents
        
        comps = calendar.dateComponents([.day], from: dateFrom, to: now)
        let yesterday = calendar.date(byAdding: Calendar.Component.day, value: -(comps.day!), to: Date())
        
        
        let predicate = HKQuery.predicateForSamples(withStart: yesterday, end: Date(), options: [])
        
        
        
        let query = HKSampleQuery(sampleType: healthKitTypesToRead!, predicate: predicate, limit: 0, sortDescriptors: nil) { query, results, error in
            var steps: Double = 0
            var distance: Double = 0
            var distanceInt:Int = 0
            
            if results != nil {
                if (results?.count)! > 0
                {
                    for result in results as! [HKQuantitySample]
                    {
                        if(result.device?.model == "iPhone")
                        {
                            
                            //                            steps += result.quantity.doubleValue(for: HKUnit.count())
                            //何メートル換算で距離を取得
                            distance += result.quantity.doubleValue(for: HKUnit.meter())
                            print(result.quantity.doubleValue(for: HKUnit.meter()))
                            distanceInt = Int(distance)
                            self.stepCountLabel.text = "\(distanceInt)"
                        }
                    }
                }
                
                
            }
            
            if error != nil {
                completion(steps, error as! NSError)
            }
            
        }
        
        healthKitStore.execute(query)
    }

  
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
