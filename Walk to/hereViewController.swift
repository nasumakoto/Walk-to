//
//  hereViewController.swift
//  Walk to
//
//  Created by 那須真 on 2017/06/27.
//  Copyright © 2017年 Makoto Nasu. All rights reserved.
//

import UIKit
import HealthKit

class hereViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var myDate: UILabel!
    
    @IBOutlet weak var myName: UILabel!
    
    @IBOutlet weak var myRecord: UILabel!
    
    @IBOutlet weak var myDescription: UITextView!
    
    @IBOutlet weak var hereProgress: UIProgressView!
    
    @IBOutlet weak var hereCity: UILabel!
    
    @IBOutlet weak var nextCity: UILabel!
    
    @IBOutlet weak var myDistance: UILabel!
    
    @IBOutlet weak var nextDistance: UILabel!
    
    @IBOutlet weak var nextTodofuken: UIImageView!

    @IBOutlet weak var hereDistance: UILabel!
    
    var timer = Timer()
    
    let now = Date()
 
    var nextClass = NSNumber()
    
    var here = NSNumber()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let now = Date()
        let jaLocale = Locale(identifier: "ja_JP")
        
        let df = DateFormatter()
        df.dateFormat = "yyyy年MM月dd日"
        myDate.text = df.string(from: now)

    }
    

    
    // 画面が表示されるたびに毎回発動
    override func viewWillAppear(_ animated: Bool) {
        
        var player = ["Naoko Takahashi","Mizuki Noguchi","Kenji Kimihara","Yuko Arimori","Hiromi Taniguchi","Toshihiko Seko","Akemi Masuda"]
        
        let r = Int(arc4random()) % player.count
        
        let filePath = Bundle.main.path(forResource: "playerList", ofType: "plist")
        
        let dic = NSDictionary(contentsOfFile: filePath!)
        let detailInfo:NSDictionary = dic![player[r]] as! NSDictionary
        
        myName.text = (detailInfo["name"] as! String)
        myRecord.text = (detailInfo["record"] as! String)
        myDescription.text = (detailInfo["description"] as! String)
        
        print(detailInfo["name"] as! String)
        print(detailInfo["record"] as! String)
        print(detailInfo["description"] as! String)
        
        go ()
        
        // AppDelegateにアクセスするための準備
        let myApp = UIApplication.shared.delegate as! AppDelegate
        let distanceInt:Double = myApp.distanceInt
        
        print(distanceInt)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.positiveFormat = "0.0"
        formatter.roundingMode = .up
        
        let formatter2 = NumberFormatter()
        formatter2.numberStyle = .decimal
        formatter2.maximumFractionDigits = 2
        formatter2.positiveFormat = "0.0"
        formatter2.roundingMode = .floor
        
        let hokkaido = distanceInt - 277.29
        
        if distanceInt < 277.2 {
            self.hereCity.text = "稚内(宗谷岬)"
            self.myDistance.text = "277.2"
            self.nextCity.text = "北海道(札幌)"
            self.here = NSNumber((value:distanceInt))
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(277.2 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"kanagawa.jpg")
            hereProgress.progress = Float(NSNumber(value:distanceInt / 277.29))
            print(hereProgress.progress)
            
        } else if distanceInt < 531.0 {
            self.hereCity.text = "北海道(札幌)"
            self.myDistance.text = "253.8"
            self.nextCity.text = "青森県(青森)"
            self.here = NSNumber(value: distanceInt - 277.2)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(531.0 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"aomori")
            hereProgress.progress = Float(NSNumber(value:hokkaido / 253.8))
            print(hereProgress.progress)
        }
        
        
    }
    
    func go () {
//        hereProgress.setProgress(5.0, animated: true)
        hereProgress.transform = CGAffineTransform(scaleX: 1.0, y: 7.0)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
