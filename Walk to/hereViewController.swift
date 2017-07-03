//
//  hereViewController.swift
//  Walk to
//
//  Created by 那須真 on 2017/06/27.
//  Copyright © 2017年 Makoto Nasu. All rights reserved.
//

import UIKit
import HealthKit

class hereViewController: UIViewController {

    @IBOutlet weak var myDate: UILabel!
    
    @IBOutlet weak var myName: UILabel!
    
    @IBOutlet weak var myRecord: UILabel!
    
    @IBOutlet weak var myDescription: UITextView!
    
    
    
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
