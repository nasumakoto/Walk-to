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
    
    @IBOutlet weak var txtDate: UITextField!
    
    @IBOutlet weak var settingBtn: UIButton!
    
    var timer = Timer()
    
    let healthKitStore = HKHealthStore()
    
    let now = Date()
    
    var num = NSNumber()
    
    var nextClass = NSNumber()
    
    let df = DateFormatter()
    
    let inputDatePicker = UIDatePicker()
    
    var healtFlag = true // HealthKitが使える時はtrue、使えないときはfalse
    
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        myStartImage.isHidden = false
        let image = UIImage.gif(name: "loading")
        myStartImage.image = image
        
        df.dateFormat = "yyyy年MM月dd日"
        df.timeZone = TimeZone.ReferenceType.local
        myDate.text = df.string(from: now)
        print(df.string(from: now))
        
        
        //UserDefaultからdataをとりだす
        //もし保存されている情報が存在しない場合、trueを初期値とする
        var myDefault = UserDefaults.standard
        
        var calendar = Calendar.current
        var startDate = calendar.date(byAdding: .day, value: -1, to: calendar.startOfDay(for: now))

        
//        var startDate = Date()

        if myDefault.object(forKey: "startDay") != nil {
            startDate = myDefault.object(forKey: "startDay") as! Date
        }
        
        let pickerDate = startDate
        
        let yy = DateFormatter()
        yy.timeZone = TimeZone.ReferenceType.local
        yy.dateFormat = "yyyy"
        let dlYear = yy.string(from: pickerDate!)
        let MM = DateFormatter()
        MM.timeZone = TimeZone.ReferenceType.local
        MM.dateFormat = "MM"
        let dlMonth = MM.string(from: pickerDate!)
        let dd = DateFormatter()
        dd.timeZone = TimeZone.ReferenceType.local
        dd.dateFormat = "dd"
        let dlday = dd.string(from: pickerDate!)
        print(dlYear)
        print(dlMonth)
        print(dlday)
        
//        let pickerDate = inputDatePicker.date
        myStartDay.text = df.string(for: pickerDate)
        
//        let calendar = Calendar.current
        let dateFrom = calendar.date(from: DateComponents(year: Int(dlYear), month: Int(dlMonth), day: Int(dlday)))!
//      myStartDay.text = df.string(for: pickerDate)
//      myStartDay.text = df.string(for:dateFrom)
        
        
        // DatePickerの設定(日付用)
        inputDatePicker.datePickerMode = UIDatePickerMode.date
        txtDate.inputView = inputDatePicker
        
        // キーボードに表示するツールバーの表示
        let pickerToolBar = UIToolbar(frame:CGRect(x:0.0, y:0.0, width:0.0, height:50.0))
        pickerToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-50.0)
        pickerToolBar.barStyle = .blackTranslucent
        pickerToolBar.tintColor = UIColor.white
        pickerToolBar.backgroundColor = UIColor.white
        
        //ボタンの設定
        //右寄せのためのスペース設定
        let spaceBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace,target: self,action: "")
        //完了ボタンを設定
        let toolBarBtn = UIBarButtonItem(title: "決定", style: .done, target: self, action: #selector(toolBarBtnPush))
        
        //ツールバーにボタンを表示
        pickerToolBar.items = [spaceBarBtn,toolBarBtn]
        txtDate.inputAccessoryView = pickerToolBar
        

        if(checkAuthorization())
        {
            print("yeah")
            if(HKHealthStore.isHealthDataAvailable())
            {
                recentSteps() { steps, error in
                    DispatchQueue.main.async {
                        self.stepCountLabel.text = String(format:"%.0f", steps)
                    }
                    
                }
                
            }else {
            self.myStartImage.isHidden = true
                healtFlag = false

            }
            
        }else {
            self.myStartImage.isHidden = true
            healtFlag = false

        }
        
        
    }

    @IBAction func pushBtn(_ sender: UIButton) {
        txtDate.becomeFirstResponder()
    }
    
    //完了を押すとピッカーの値を、テキストフィールドに挿入して、ピッカーを閉じる
    func toolBarBtnPush(sender: UIBarButtonItem){
        
        let pickerDate = inputDatePicker.date
        myStartDay.text = df.string(for: pickerDate)
        
        self.view.endEditing(true)
        
        var myDefault = UserDefaults.standard
        
        // データを書き込んで
        myDefault.set(pickerDate, forKey: "startDay")
        
        // 即反映させる
        myDefault.synchronize()
        
        
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
        
        myStartImage.isHidden = false
        let image = UIImage.gif(name: "loading")
        myStartImage.image = image
        
        
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
                self.recentSteps() { steps, error in
                    DispatchQueue.main.async {
                        self.stepCountLabel.text = String(format:"%.0f", steps)
                    }
                    
                }
                
                
            })
        }
        else
        {
            isEnabled = false
        }
        
        return isEnabled
    }
    


    // 画面が表示されるたびに毎回発動
    override func viewWillAppear(_ animated: Bool) {
        
//        df.dateFormat = "yyyy年MM月dd日"
//        df.timeZone = TimeZone.ReferenceType.local
//        myDate.text = df.string(from: now)
//        print(df.string(from: now))
        
     go ()
    
    }
    
   
    
     override func viewDidAppear(_ animated: Bool) {

        if healtFlag == false{
        let alertController = UIAlertController(title:"このアプリはiPadではご利用できません", message:"このアプリはiPhone専用です。iPadではご利用できません。", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController,animated: true,completion: nil)
        }

    }
    
    
    
   
    func go () {
        totalProgress.transform = CGAffineTransform(scaleX: 1.0, y: 7.0)
    }

    func updateStepCount()
    {

    }

    
    func recentSteps(completion: @escaping (Double, NSError?) -> () )
    {
        let healthKitTypesToRead = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)
        
        
        //UserDefaultからdataをとりだす
        //もし保存されている情報が存在しない場合、trueを初期値とする
        var myDefault = UserDefaults.standard
        
        let calendar = Calendar.current
        var startDate = calendar.date(byAdding: .day, value: -1, to: calendar.startOfDay(for: now))
        
        if myDefault.object(forKey: "startDay") != nil {
            startDate = myDefault.object(forKey: "startDay") as! Date
        }
        
        
        let pickerDate = startDate
        
        let yy = DateFormatter()
        yy.timeZone = TimeZone.ReferenceType.local
        yy.dateFormat = "yyyy"
        let dlYear = yy.string(from: pickerDate!)
        let MM = DateFormatter()
        MM.timeZone = TimeZone.ReferenceType.local
        MM.dateFormat = "MM"
        let dlMonth = MM.string(from: pickerDate!)
        let dd = DateFormatter()
        dd.timeZone = TimeZone.ReferenceType.local
        dd.dateFormat = "dd"
        let dlday = dd.string(from: pickerDate!)
        print(dlYear)
        print(dlMonth)
        print(dlday)
        
//        let calendar = Calendar.current
        let dateFrom = calendar.date(from: DateComponents(year: Int(dlYear), month: Int(dlMonth), day: Int(dlday)))!
        
        //        myStartDay.text = df.string(for:dateFrom)
        
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
                
                
                var comps: DateComponents
                
                comps = calendar.dateComponents([.day], from: dateFrom, to: self.now)
                self.myDays.text = String(comps.day!)
                print(comps.day!)
                
                
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
                    self.totalProgress.progress = Float(NSNumber(value: distanceInt / 1000.0))
                }else if distanceInt < 2000.0 {
                    self.nextClass = NSNumber(value:(2000.0 - distanceInt))
                    self.nextDistance.text = formatter.string(from: self.nextClass)!
                    self.myClassImage.image = UIImage(named:"gold")
                    self.totalProgress.progress = Float(NSNumber(value: distanceInt / 2000.0))
                }else if distanceInt < 3000.0 {
                    self.nextClass = NSNumber(value:(3000.0 - distanceInt))
                    self.nextDistance.text = formatter.string(from: self.nextClass)!
                    self.myClassImage.image = UIImage(named:"platinum")
                    self.totalProgress.progress = Float(NSNumber(value: distanceInt / 3000.0))
                }else if distanceInt >= 3000.0 {
                    self.nextClass = NSNumber(value:0)
                    self.nextDistance.text = formatter.string(from: self.nextClass)!
                    self.myClassImage.image = UIImage(named:"diamond")
                    self.totalProgress.progress = 0.2
                }
                
                self.myStartImage.isHidden = true

                
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
