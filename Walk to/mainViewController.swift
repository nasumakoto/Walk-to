//
//  mainViewController.swift
//  Walk to
//
//  Created by 那須真 on 2017/06/27.
//  Copyright © 2017年 Makoto Nasu. All rights reserved.
//

import UIKit
import HealthKit
import CoreMotion

class mainViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var myDate: UILabel!
    
    @IBOutlet weak var myTotalDistance: UILabel!
    
    @IBOutlet weak var myDays: UILabel!
    
    @IBOutlet weak var totalProgress: UIProgressView!
    
    @IBOutlet weak var nextDistance: UILabel!
    
    var timer = Timer()
    
 
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        let now = Date()
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
        

    }

    
    
    func go () {
        
        totalProgress.progress = 0.000005
        totalProgress.setProgress(1.0, animated: true)
        totalProgress.transform = CGAffineTransform(scaleX: 1.0, y: 7.0)
    
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
