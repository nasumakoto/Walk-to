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
    
    @IBOutlet weak var totalProgress: UIProgressView!
    
    @IBOutlet weak var nextDistance: UILabel!
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        let now = Date()
        let jaLocale = Locale(identifier: "ja_JP")
        
        let df = DateFormatter()
        df.dateFormat = "yyyy年MM月dd日"
        myDate.text = df.string(from: now)
        
        totalProgress.transform = CGAffineTransformMakeScale(1.0, 10.0)  //この行を追加
        
        
    }

    // 画面が表示されるたびに毎回発動
    override func viewWillAppear(_ animated: Bool) {
        
 
        

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
