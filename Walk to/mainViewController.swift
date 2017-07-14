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
    
    @IBOutlet weak var myStartDay: UILabel!
    
    @IBOutlet weak var myDays: UILabel!
    
    @IBOutlet weak var myAverage: UILabel!
    
    @IBOutlet weak var totalProgress: UIProgressView!
    
   @IBOutlet weak var nextDistance: UILabel!
    
    @IBOutlet weak var myClassImage: UIImageView!
    
    @IBOutlet weak var myStartImage: UIImageView!
    
    var timer = Timer()
    
    let healthKitStore = HKHealthStore()
    
    let now = Date()
    
    var num = NSNumber()
    
    var nextClass = NSNumber()
    
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        myStartImage.isHidden = false
        let image = UIImage.gif(name: "loading")
        myStartImage.image = image
        
//        let jaLocale = Locale(identifier: "ja_JP")
        
        let df = DateFormatter()
        df.dateFormat = "yyyy年MM月dd日"
        df.timeZone = TimeZone.ReferenceType.local
        myDate.text = df.string(from: now)
        
        let yy = DateFormatter()
        yy.timeZone = TimeZone.ReferenceType.local
        yy.dateFormat = "yyyy"
        let dlYear = yy.string(from: now)
        let MM = DateFormatter()
        MM.timeZone = TimeZone.ReferenceType.local
        MM.dateFormat = "MM"
        let dlMonth = MM.string(from: now)
        let dd = DateFormatter()
        dd.timeZone = TimeZone.ReferenceType.local
        dd.dateFormat = "dd"
        let dlday = dd.string(from: now)
        print(dlYear)
        print(dlMonth)
        print(dlday)
        
        let calendar = Calendar.current
        let dateFrom = calendar.date(from: DateComponents(year: Int(dlYear), month: Int(dlMonth), day: Int(dlday)))!
        
        var myDefault = UserDefaults.standard
        //        var firstDay = Date()
        if myDefault.object(forKey: "now") != nil {
            let now = myDefault.object(forKey: "now") as! Date
        }else{
            myDefault.set(now, forKey: "now")
            myDefault.synchronize()
        }
        
//        let calendar = Calendar.current
//        let dateFrom = calendar.date(from: DateComponents(year: 2017, month: 5, day: 8))!
//        var myDefault = UserDefaults.standard
//        
//        var dateFrom = Date()
//        
//        if myDefault.object(forKey: "dateFrom") != nil {
//            dateFrom = myDefault.object(forKey: "dateFrom") as! Date
//        }else{
//            myDefault.set(dateFrom, forKey: "dateFrom")
//            myDefault.synchronize()
//        }
        
        var comps: DateComponents
        
        comps = calendar.dateComponents([.day], from: dateFrom, to: now)
        myDays.text = String(comps.day!)
        print(comps.day!) // 14012
        
        myStartDay.text = df.string(for:dateFrom)
        
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
    

    // 画面が表示されるたびに毎回発動
    override func viewWillAppear(_ animated: Bool) {

        go ()
    
        }
    
    func go () {
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
        
        let yy = DateFormatter()
        yy.timeZone = TimeZone.ReferenceType.local
        yy.dateFormat = "yyyy"
        let dlYear = yy.string(from: now)
        let MM = DateFormatter()
        MM.timeZone = TimeZone.ReferenceType.local
        MM.dateFormat = "MM"
        let dlMonth = MM.string(from: now)
        let dd = DateFormatter()
        dd.timeZone = TimeZone.ReferenceType.local
        dd.dateFormat = "dd"
        let dlday = dd.string(from: now)
        print(dlYear)
        print(dlMonth)
        print(dlday)

        let calendar = Calendar.current
//        let dateFrom = calendar.date(from: DateComponents(year: 2017, month: 7, day: 14))!

       let dateFrom = calendar.date(from: DateComponents(year: Int(dlYear), month: Int(dlMonth), day: Int(dlday)))!
        
        var myDefault = UserDefaults.standard
//        var firstDay = Date()
        if myDefault.object(forKey: "now") != nil {
        let now = myDefault.object(forKey: "now") as! Date
        }else{
            myDefault.set(now, forKey: "now")
            myDefault.synchronize()
        }

        
        var comps: DateComponents
        comps = calendar.dateComponents([.day], from: dateFrom, to: now)
        let yesterday = calendar.date(byAdding: Calendar.Component.day, value: -(comps.day!), to: Date())
        
        let predicate = HKQuery.predicateForSamples(withStart: yesterday, end: Date(), options: [])
        
        let query = HKSampleQuery(sampleType: healthKitTypesToRead!, predicate: predicate, limit: 0, sortDescriptors: nil) { query, results, error in
            var steps: Double = 0
            var distance: Double = 0
            var distanceInt:Double = 0
            
            if results != nil {
                if (results?.count)! > 0
                {
                    for result in results as! [HKQuantitySample]
                    {
                        if(result.device?.model == "iPhone")
                        {
                            
                            //steps += result.quantity.doubleValue(for: HKUnit.count())
                            //何メートル換算で距離を取得
                            distance += result.quantity.doubleValue(for: HKUnit.meter())
                            print(result.quantity.doubleValue(for: HKUnit.meter()))
                             distanceInt = Double(distance/1000)
                        }
                    }
                }
                
                //global変数に代入
                // AppDelegateにアクセスするための準備
                let myApp = UIApplication.shared.delegate as! AppDelegate
                myApp.distanceInt = Double(distanceInt)
                
                print(myApp.distanceInt)
                
                let distanceInt:Double = myApp.distanceInt
                
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                formatter.maximumFractionDigits = 2
                formatter.positiveFormat = "0.0"
                formatter.roundingMode = .floor
                self.num = NSNumber(value:distanceInt)
                self.stepCountLabel.text = formatter.string(from: self.num)!
                
                
                let average = Double(comps.day!)
                formatter.numberStyle = .decimal
                formatter.maximumFractionDigits = 2
                formatter.positiveFormat = "0.0"
                formatter.roundingMode = .up
                self.num = NSNumber(value:(distanceInt / average))
                self.myAverage.text = formatter.string(from: self.num)!
                
                if distanceInt < 200.0 {
                    self.nextClass = NSNumber(value:(200.0 - distanceInt))
                    self.nextDistance.text = formatter.string(from: self.nextClass)!
                    self.myClassImage.image = UIImage(named:"beginner")
                    self.totalProgress.progress = Float(NSNumber(value: distanceInt / 200.0))


                }else if distanceInt < 500.0 {
                    self.nextClass = NSNumber(value:(500.0 - distanceInt))
                    self.nextDistance.text = formatter.string(from: self.nextClass)!
                    self.myClassImage.image = UIImage(named:"bronze")
                    self.totalProgress.progress = Float(NSNumber(value: distanceInt / 500.0))
                    
                    
                }else if distanceInt < 1000.0 {
                    self.nextClass = NSNumber(value:(1000.0 - distanceInt))
                    self.nextDistance.text = formatter.string(from: self.nextClass)!
                    self.myClassImage.image = UIImage(named:"silver")
                }else if distanceInt < 2000.0 {
                    self.nextClass = NSNumber(value:(2000.0 - distanceInt))
                    self.nextDistance.text = formatter.string(from: self.nextClass)!
                    self.myClassImage.image = UIImage(named:"gold")
                }else if distanceInt < 3000.0 {
                    self.nextClass = NSNumber(value:(3000.0 - distanceInt))
                    self.nextDistance.text = formatter.string(from: self.nextClass)!
                    self.myClassImage.image = UIImage(named:"platinum")
                }else if distanceInt >= 3000.0 {
                    self.nextClass = NSNumber(value:0)
                    self.nextDistance.text = formatter.string(from: self.nextClass)!
                    self.myClassImage.image = UIImage(named:"diamond")
                }
                
                
            }
            self.myStartImage.isHidden = true

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
