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



    }
    

    
    // 画面が表示されるたびに毎回発動
    override func viewWillAppear(_ animated: Bool) {
        
        let df = DateFormatter()
        df.dateFormat = "yyyy年MM月dd日"
        df.timeZone = TimeZone.ReferenceType.local
        myDate.text = df.string(from: now)
        
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
        
        
        
        
        
        if distanceInt < 277.2 {
            self.hereCity.text = "稚内(宗谷岬)"
            self.myDistance.text = "277.2"
            self.nextCity.text = "北海道(札幌)"
            self.here = NSNumber((value:distanceInt))
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(277.2 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"hokkaido")
            hereProgress.progress = Float(NSNumber(value:distanceInt / 277.2))
        } else if distanceInt < 531.0 {
            self.hereCity.text = "北海道(札幌)"
            self.myDistance.text = "253.8"
            self.nextCity.text = "青森県(青森)"
            self.here = NSNumber(value: distanceInt - 277.2)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(531.0 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"aomori")
            let hokkaido = distanceInt - 277.2
            hereProgress.progress = Float(NSNumber(value:hokkaido / 253.8))
        } else if distanceInt < 660.3 {
            self.hereCity.text = "青森県(青森)"
            self.myDistance.text = "129.3"
            self.nextCity.text = "岩手県(盛岡)"
            self.here = NSNumber(value: distanceInt - 531.0)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(660.3 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"iwate")
            let aomori = distanceInt - 531.0
            hereProgress.progress = Float(NSNumber(value:aomori / 129.3))
        } else if distanceInt < 750.4 {
            self.hereCity.text = "岩手県(盛岡)"
            self.myDistance.text = "90.1"
            self.nextCity.text = "秋田県(秋田)"
            self.here = NSNumber(value: distanceInt - 660.3)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(750.4 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"akita")
            let iwate = distanceInt - 660.3
            hereProgress.progress = Float(NSNumber(value:iwate / 129.3))
        } else if distanceInt < 915.8 {
            self.hereCity.text = "秋田県(秋田)"
            self.myDistance.text = "165.6"
            self.nextCity.text = "山形県(山形)"
            self.here = NSNumber(value: distanceInt - 750.4)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(915.8 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"yamagata")
            let akita = distanceInt - 750.4
            hereProgress.progress = Float(NSNumber(value:akita / 165.6))
        } else if distanceInt < 996.4 {
            self.hereCity.text = "山形県(山形)"
            self.myDistance.text = "44.6"
            self.nextCity.text = "宮城県(仙台)"
            self.here = NSNumber(value: distanceInt - 915.8)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(996.4 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"miyagi")
            let yamagata = distanceInt - 915.8
            hereProgress.progress = Float(NSNumber(value:yamagata / 44.6))
        } else if distanceInt < 1064.1 {
            self.hereCity.text = "宮城県(仙台)"
            self.myDistance.text = "67.7"
            self.nextCity.text = "福島県(福島)"
            self.here = NSNumber(value: distanceInt - 996.4)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(1064.1 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"fukushima")
            let miyagi = distanceInt - 996.4
            hereProgress.progress = Float(NSNumber(value:miyagi / 67.7))
        } else if distanceInt < 1192.4 {
            self.hereCity.text = "福島県(福島)"
            self.myDistance.text = "128.3"
            self.nextCity.text = "新潟県(新潟)"
            self.here = NSNumber(value: distanceInt - 1064.1)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(1192.4 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"niigata")
            let fukushima = distanceInt - 1064.1
            hereProgress.progress = Float(NSNumber(value:fukushima / 128.3))
        } else if distanceInt < 1360.1 {
            self.hereCity.text = "新潟県(新潟)"
            self.myDistance.text = "167.7"
            self.nextCity.text = "群馬県(前橋)"
            self.here = NSNumber(value: distanceInt - 1192.4)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(1360.4 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"gunma")
            let niigata = distanceInt - 1192.4
            hereProgress.progress = Float(NSNumber(value:niigata / 167.7))
        } else if distanceInt < 1436.3 {
            self.hereCity.text = "群馬県(前橋)"
            self.myDistance.text = "76.2"
            self.nextCity.text = "栃木県(宇都宮)"
            self.here = NSNumber(value: distanceInt - 1360.1)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(1436.3 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"tochigi")
            let gunma = distanceInt - 1360.1
            hereProgress.progress = Float(NSNumber(value:gunma / 76.2))
        } else if distanceInt < 1492.6 {
            self.hereCity.text = "栃木県(宇都宮)"
            self.myDistance.text = "56.3"
            self.nextCity.text = "茨城県(水戸)"
            self.here = NSNumber(value: distanceInt - 1436.3)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(1492.6 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"ibaraki")
            let tochigi = distanceInt - 1436.3
            hereProgress.progress = Float(NSNumber(value:tochigi / 56.3))
        } else if distanceInt < 1579.4 {
            self.hereCity.text = "茨城県(水戸)"
            self.myDistance.text = "86.8"
            self.nextCity.text = "千葉県(千葉)"
            self.here = NSNumber(value: distanceInt - 1492.6)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(1579.3 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"chiba")
            let ibaraki = distanceInt - 1492.6
            hereProgress.progress = Float(NSNumber(value:ibaraki / 86.8))
        } else if distanceInt < 1630.6 {
            self.hereCity.text = "千葉県(千葉)"
            self.myDistance.text = "51.2"
            self.nextCity.text = "埼玉県(さいたま)"
            self.here = NSNumber(value: distanceInt - 1579.4)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(1630.6 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"saitama")
            let chiba = distanceInt - 1579.4
            hereProgress.progress = Float(NSNumber(value:chiba / 51.2))
        } else if distanceInt < 1649.6 {
            self.hereCity.text = "埼玉県(さいたま)"
            self.myDistance.text = "19.0"
            self.nextCity.text = "東京都(東京)"
            self.here = NSNumber(value: distanceInt - 1630.6)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(1649.6 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"tokyo")
            let saitama = distanceInt - 1630.6
            hereProgress.progress = Float(NSNumber(value:saitama / 19.0))
        } else if distanceInt < 1676.8 {
            self.hereCity.text = "東京都(東京)"
            self.myDistance.text = "27.2"
            self.nextCity.text = "神奈川県(横浜)"
            self.here = NSNumber(value: distanceInt - 1649.6)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(1676.8 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"kanagawa")
            let tokyo = distanceInt - 1649.6
            hereProgress.progress = Float(NSNumber(value:tokyo / 27.2))
        } else if distanceInt < 1777.1 {
            self.hereCity.text = "神奈川県(横浜)"
            self.myDistance.text = "100.3"
            self.nextCity.text = "山梨県(甲府)"
            self.here = NSNumber(value: distanceInt - 1676.8)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(1777.1 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"yamanashi")
            let kanagawa = distanceInt - 1676.8
            hereProgress.progress = Float(NSNumber(value:kanagawa / 100.3))
        } else if distanceInt < 1855.2 {
            self.hereCity.text = "山梨県(甲府)"
            self.myDistance.text = "78.1"
            self.nextCity.text = "静岡県(静岡)"
            self.here = NSNumber(value: distanceInt - 1777.1)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(1855.2 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"shizuoka")
            let yamanashi = distanceInt - 1777.1
            hereProgress.progress = Float(NSNumber(value:yamanashi / 78.1))
        } else if distanceInt < 2041.9 {
            self.hereCity.text = "静岡県(静岡)"
            self.myDistance.text = "186.7"
            self.nextCity.text = "長野県(長野)"
            self.here = NSNumber(value: distanceInt - 1855.2)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(2041.9 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"nagano")
            let shizuoka = distanceInt - 1855.2
            hereProgress.progress = Float(NSNumber(value:shizuoka / 186.7))
        } else if distanceInt < 2128.7 {
            self.hereCity.text = "長野県(長野)"
            self.myDistance.text = "86.8"
            self.nextCity.text = "富山県(富山)"
            self.here = NSNumber(value: distanceInt - 2041.9)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(2128.7 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"toyama")
            let nagano = distanceInt - 2041.9
            hereProgress.progress = Float(NSNumber(value:nagano / 86.8))
        } else if distanceInt < 2181.6 {
            self.hereCity.text = "富山県(富山)"
            self.myDistance.text = "53.6"
            self.nextCity.text = "石川県(金沢)"
            self.here = NSNumber(value: distanceInt - 2128.7)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(2181.6 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"ishikawa")
            let toyama = distanceInt - 2128.7
            hereProgress.progress = Float(NSNumber(value:toyama / 53.6))
        } else if distanceInt < 2250.6 {
            self.hereCity.text = "石川県(金沢)"
            self.myDistance.text = "69.0"
            self.nextCity.text = "福井県(福井)"
            self.here = NSNumber(value: distanceInt - 2181.6)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(2250.6 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"fukui")
            let ishikawa = distanceInt - 2181.6
            hereProgress.progress = Float(NSNumber(value:ishikawa / 69.0))
        } else if distanceInt < 2338.0 {
            self.hereCity.text = "福井県(福井)"
            self.myDistance.text = "87.4"
            self.nextCity.text = "岐阜県(岐阜)"
            self.here = NSNumber(value: distanceInt - 2250.6)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(2338.0 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"gifu")
            let fukui = distanceInt - 2250.6
            hereProgress.progress = Float(NSNumber(value:fukui / 87.4))
        } else if distanceInt < 2366.8 {
            self.hereCity.text = "岐阜県(岐阜)"
            self.myDistance.text = "28.8"
            self.nextCity.text = "愛知県(名古屋)"
            self.here = NSNumber(value: distanceInt - 2338.0)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(2366.8 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"aichi")
            let gifu = distanceInt - 2338.0
            hereProgress.progress = Float(NSNumber(value:gifu / 28.8))
        } else if distanceInt < 2428.6 {
            self.hereCity.text = "愛知県(名古屋)"
            self.myDistance.text = "61.8"
            self.nextCity.text = "三重県(津)"
            self.here = NSNumber(value: distanceInt - 2366.8)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(2428.0 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"mie")
            let aichi = distanceInt - 2366.8
            hereProgress.progress = Float(NSNumber(value:aichi / 61.8))
        } else if distanceInt < 2525.3 {
            self.hereCity.text = "三重県(津)"
            self.myDistance.text = "96.7"
            self.nextCity.text = "滋賀県(大津)"
            self.here = NSNumber(value: distanceInt - 2428.6)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(2525.3 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"shiga")
            let mie = distanceInt - 2428.6
            hereProgress.progress = Float(NSNumber(value:mie / 96.7))
        } else if distanceInt < 2535.8 {
            self.hereCity.text = "滋賀県(大津)"
            self.myDistance.text = "10.5"
            self.nextCity.text = "京都府(京都)"
            self.here = NSNumber(value: distanceInt - 2525.3)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(2535.8 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"kyoto")
            let shiga = distanceInt - 2525.3
            hereProgress.progress = Float(NSNumber(value:shiga / 10.5))
        } else if distanceInt < 2573.8 {
            self.hereCity.text = "京都府(京都)"
            self.myDistance.text = "38.0"
            self.nextCity.text = "奈良県(奈良)"
            self.here = NSNumber(value: distanceInt - 2535.8)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(2573.8 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"nara")
            let kyoto = distanceInt - 2535.8
            hereProgress.progress = Float(NSNumber(value:kyoto / 38.0))
        } else if distanceInt < 2653.4 {
            self.hereCity.text = "奈良県(奈良)"
            self.myDistance.text = "79.6"
            self.nextCity.text = "和歌山県(和歌山)"
            self.here = NSNumber(value: distanceInt - 2573.8)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(2653.4 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"wakayama")
            let nara = distanceInt - 2573.8
            hereProgress.progress = Float(NSNumber(value:nara / 79.6))
        } else if distanceInt < 2713.9 {
            self.hereCity.text = "和歌山県(和歌山)"
            self.myDistance.text = "60.5"
            self.nextCity.text = "大阪府(大阪)"
            self.here = NSNumber(value: distanceInt - 2653.4)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(2713.9 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"osaka")
            let wakayama = distanceInt - 2653.4
            hereProgress.progress = Float(NSNumber(value:wakayama / 60.5))
        } else if distanceInt < 2744.8 {
            self.hereCity.text = "大阪府(大阪)"
            self.myDistance.text = "30.9"
            self.nextCity.text = "兵庫県(神戸)"
            self.here = NSNumber(value: distanceInt - 2713.9)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(2744.8 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"hyogo")
            let osaka = distanceInt - 2713.9
            hereProgress.progress = Float(NSNumber(value:osaka / 30.9))
        } else if distanceInt < 2869.5 {
            self.hereCity.text = "兵庫県(神戸)"
            self.myDistance.text = "124.7"
            self.nextCity.text = "鳥取県(鳥取)"
            self.here = NSNumber(value: distanceInt - 2744.8)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(2869.5 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"tottori")
            let hyogo = distanceInt - 2744.8
            hereProgress.progress = Float(NSNumber(value:hyogo / 124.7))
        } else if distanceInt < 2966.9 {
            self.hereCity.text = "鳥取県(鳥取)"
            self.myDistance.text = "97.4"
            self.nextCity.text = "岡山県(岡山)"
            self.here = NSNumber(value: distanceInt - 2869.5)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(2966.9 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"okayama")
            let tottori = distanceInt - 2869.5
            hereProgress.progress = Float(NSNumber(value:tottori / 97.4))
        } else if distanceInt < 3003.9 {
            self.hereCity.text = "岡山県(岡山)"
            self.myDistance.text = "37.0"
            self.nextCity.text = "香川県(高松)"
            self.here = NSNumber(value: distanceInt - 2966.9)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(3003.9 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"kagawa")
            let okayama = distanceInt - 2966.9
            hereProgress.progress = Float(NSNumber(value:okayama / 37.0))
        } else if distanceInt < 3060.4 {
            self.hereCity.text = "香川県(高松)"
            self.myDistance.text = "56.5"
            self.nextCity.text = "徳島県(徳島)"
            self.here = NSNumber(value: distanceInt - 3003.9)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(3060.4 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"tokushima")
            let kagawa = distanceInt - 3003.9
            hereProgress.progress = Float(NSNumber(value:kagawa / 56.5))
        } else if distanceInt < 3170.9 {
            self.hereCity.text = "徳島県(徳島)"
            self.myDistance.text = "110.5"
            self.nextCity.text = "高知県(高知)"
            self.here = NSNumber(value: distanceInt - 3060.4)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(3170.9 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"kouchi")
            let tokushima = distanceInt - 3060.4
            hereProgress.progress = Float(NSNumber(value:tokushima / 110.5))
        } else if distanceInt < 3248.4 {
            self.hereCity.text = "高知県(高知)"
            self.myDistance.text = "77.5"
            self.nextCity.text = "愛媛県(松山)"
            self.here = NSNumber(value: distanceInt - 3170.9)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(3248.4 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"ehime")
            let kouchi = distanceInt - 3170.9
            hereProgress.progress = Float(NSNumber(value:kouchi / 77.5))
        } else if distanceInt < 3316.1 {
            self.hereCity.text = "愛媛県(松山)"
            self.myDistance.text = "67.7"
            self.nextCity.text = "広島県(広島)"
            self.here = NSNumber(value: distanceInt - 3248.4)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(3316.1 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"hiroshima")
            let ehime = distanceInt - 3248.4
            hereProgress.progress = Float(NSNumber(value:ehime / 67.7))
        } else if distanceInt < 3447.1 {
            self.hereCity.text = "広島県(広島)"
            self.myDistance.text = "131.0"
            self.nextCity.text = "島根県(松江)"
            self.here = NSNumber(value: distanceInt - 3316.1)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(3447.1 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"shimane")
            let hiroshima = distanceInt - 3316.1
            hereProgress.progress = Float(NSNumber(value:hiroshima / 131.0))
        } else if distanceInt < 3650.2 {
            self.hereCity.text = "島根県(松江)"
            self.myDistance.text = "203.1"
            self.nextCity.text = "山口県(山口)"
            self.here = NSNumber(value: distanceInt - 3447.1)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(3650.2 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"yamaguchi")
            let shimane = distanceInt - 3447.1
            hereProgress.progress = Float(NSNumber(value:shimane / 203.1))
        } else if distanceInt < 3766.9 {
            self.hereCity.text = "山口県(山口)"
            self.myDistance.text = "116.7"
            self.nextCity.text = "福岡県(福岡)"
            self.here = NSNumber(value: distanceInt - 3650.2)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(3766.9 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"fukuoka")
            let yamaguchi = distanceInt - 3650.2
            hereProgress.progress = Float(NSNumber(value:yamaguchi / 116.7))
        } else if distanceInt < 3808.0 {
            self.hereCity.text = "福岡県(福岡)"
            self.myDistance.text = "41.1"
            self.nextCity.text = "佐賀県(佐賀)"
            self.here = NSNumber(value: distanceInt - 3766.9)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(3808.0 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"saga")
            let fukuoka = distanceInt - 3766.9
            hereProgress.progress = Float(NSNumber(value:fukuoka / 41.1))
        } else if distanceInt < 3876.1 {
            self.hereCity.text = "佐賀県(佐賀)"
            self.myDistance.text = "68.1"
            self.nextCity.text = "長崎県(長崎)"
            self.here = NSNumber(value: distanceInt - 3808.0)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(3876.1 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"nagasaki")
            let saga = distanceInt - 3808.0
            hereProgress.progress = Float(NSNumber(value:saga / 68.1))
        } else if distanceInt < 3957.6 {
            self.hereCity.text = "長崎県(長崎)"
            self.myDistance.text = "81.5"
            self.nextCity.text = "熊本県(熊本)"
            self.here = NSNumber(value: distanceInt - 3876.1)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(3957.6 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"kumamoto")
            let nagasaki = distanceInt - 3876.1
            hereProgress.progress = Float(NSNumber(value:nagasaki / 81.5))
        } else if distanceInt < 4053.0 {
            self.hereCity.text = "熊本県(熊本)"
            self.myDistance.text = "95.4"
            self.nextCity.text = "大分県(大分)"
            self.here = NSNumber(value: distanceInt - 3957.6)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(4053.0 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"oita")
            let kumamoto = distanceInt - 3957.6
            hereProgress.progress = Float(NSNumber(value:kumamoto / 95.4))
        } else if distanceInt < 4201.2 {
            self.hereCity.text = "大分県(大分)"
            self.myDistance.text = "148.2"
            self.nextCity.text = "宮崎県(宮崎)"
            self.here = NSNumber(value: distanceInt - 4053.0)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(4201.2 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"miyazaki")
            let oita = distanceInt - 4053.0
            hereProgress.progress = Float(NSNumber(value:oita / 148.2))
        } else if distanceInt < 4292.0 {
            self.hereCity.text = "宮崎県(宮崎)"
            self.myDistance.text = "90.8"
            self.nextCity.text = "鹿児島県(鹿児島)"
            self.here = NSNumber(value: distanceInt - 4201.2)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(4292.0 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"kagoshima")
            let miyazaki = distanceInt - 4201.2
            hereProgress.progress = Float(NSNumber(value:miyazaki / 90.8))
        } else if distanceInt < 4947.7 {
            self.hereCity.text = "鹿児島県(鹿児島)"
            self.myDistance.text = "655.7"
            self.nextCity.text = "沖縄県(那覇)"
            self.here = NSNumber(value: distanceInt - 4292.0)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(4947.7 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"okinawa")
            let kagoshima = distanceInt - 4292.0
            hereProgress.progress = Float(NSNumber(value:kagoshima / 655.7))
        } else if distanceInt < 5464.6 {
            self.hereCity.text = "沖縄県(那覇)"
            self.myDistance.text = "516.9"
            self.nextCity.text = "与那国島"
            self.here = NSNumber(value: distanceInt - 4947.7)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(5464.6 - distanceInt))
            self.nextDistance.text = formatter.string(from: self.nextClass)!
            self.nextTodofuken.image = UIImage(named:"yonakuni")
            let okinawa = distanceInt - 4947.7
            hereProgress.progress = Float(NSNumber(value:okinawa / 516.9))
        } else if distanceInt >= 5464.6 {
            self.hereCity.text = "与那国島"
            self.myDistance.text = "COMPLETE"
            self.nextCity.text = "COMPLETE"
            self.here = NSNumber(value: distanceInt - 5464.6)
            self.hereDistance.text = formatter2.string(from: self.here)!
            self.nextClass = NSNumber(value:(0))
            self.nextDistance.text = "0"
            self.nextTodofuken.image = UIImage(named:"yonakuni")
            hereProgress.progress = 1.0
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
