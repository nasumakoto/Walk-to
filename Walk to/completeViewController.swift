//
//  completeViewController.swift
//  Walk to
//
//  Created by 那須真 on 2017/06/27.
//  Copyright © 2017年 Makoto Nasu. All rights reserved.
//

import UIKit

class completeViewController: UIViewController {
    
    @IBOutlet weak var myDate: UILabel!
    
    @IBOutlet weak var completeMapImage: UIImageView!
    
    let now = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        

        
    }
    
        // 画面が表示されるたびに毎回発動
        override func viewWillAppear(_ animated: Bool) {
            
        let df = DateFormatter()
        df.dateFormat = "yyyy年MM月dd日"
        df.timeZone = TimeZone.ReferenceType.local
        myDate.text = df.string(from: now)
            
            
        
        // AppDelegateにアクセスするための準備
        let myApp = UIApplication.shared.delegate as! AppDelegate
        let distanceInt:Double = myApp.distanceInt
        
        print(distanceInt)
        
        if distanceInt < 277.2 {
            self.completeMapImage.image = UIImage(named:"comp")
        } else if distanceInt < 531.0 {
            self.completeMapImage.image = UIImage(named:"comp_wakkanai")
        } else if distanceInt < 660.3 {
            self.completeMapImage.image = UIImage(named:"comp_hokkaido")
        } else if distanceInt < 750.4 {
            self.completeMapImage.image = UIImage(named:"comp_aomori")
        } else if distanceInt < 915.8 {
            self.completeMapImage.image = UIImage(named:"comp_iwate")
        } else if distanceInt < 996.4 {
            self.completeMapImage.image = UIImage(named:"comp_akita")
        } else if distanceInt < 1064.1 {
            self.completeMapImage.image = UIImage(named:"comp_yamagata")
        } else if distanceInt < 1192.4 {
            self.completeMapImage.image = UIImage(named:"comp_miyagi")
        } else if distanceInt < 1360.1 {
            self.completeMapImage.image = UIImage(named:"comp_fukushima")
        } else if distanceInt < 1436.3 {
            self.completeMapImage.image = UIImage(named:"comp_niigata")
        } else if distanceInt < 1492.6 {
            self.completeMapImage.image = UIImage(named:"comp_gunma")
        } else if distanceInt < 1579.4 {
            self.completeMapImage.image = UIImage(named:"comp_tochigi")
        } else if distanceInt < 1630.6 {
            self.completeMapImage.image = UIImage(named:"comp_ibaraki")
        } else if distanceInt < 1649.6 {
            self.completeMapImage.image = UIImage(named:"comp_chiba")
        } else if distanceInt < 1676.8 {
            self.completeMapImage.image = UIImage(named:"comp_saitama")
        } else if distanceInt < 1777.1 {
            self.completeMapImage.image = UIImage(named:"comp_tokyo")
        } else if distanceInt < 1855.2 {
            self.completeMapImage.image = UIImage(named:"comp_kanagawa")
        } else if distanceInt < 2041.9 {
            self.completeMapImage.image = UIImage(named:"comp_yamanashi")
        } else if distanceInt < 2128.7 {
            self.completeMapImage.image = UIImage(named:"comp_shizuoka")
        } else if distanceInt < 2181.6 {
            self.completeMapImage.image = UIImage(named:"comp_nagano")
        } else if distanceInt < 2250.6 {
            self.completeMapImage.image = UIImage(named:"comp_toyama")
        } else if distanceInt < 2338.0 {
            self.completeMapImage.image = UIImage(named:"comp_ishikawa")
        } else if distanceInt < 2366.8 {
            self.completeMapImage.image = UIImage(named:"comp_fukui")
        } else if distanceInt < 2428.6 {
            self.completeMapImage.image = UIImage(named:"comp_gifu")
        } else if distanceInt < 2525.3 {
            self.completeMapImage.image = UIImage(named:"comp_aichi")
        } else if distanceInt < 2535.8 {
            self.completeMapImage.image = UIImage(named:"comp_mie")
        } else if distanceInt < 2573.8 {
            self.completeMapImage.image = UIImage(named:"comp_shiga")
        } else if distanceInt < 2653.4 {
            self.completeMapImage.image = UIImage(named:"comp_kyoto")
        } else if distanceInt < 2713.9 {
            self.completeMapImage.image = UIImage(named:"comp_nara")
        } else if distanceInt < 2744.8 {
            self.completeMapImage.image = UIImage(named:"comp_wakayama")
        } else if distanceInt < 2869.5 {
            self.completeMapImage.image = UIImage(named:"comp_osaka")
        } else if distanceInt < 2966.9 {
            self.completeMapImage.image = UIImage(named:"comp_hyogo")
        } else if distanceInt < 3003.9 {
            self.completeMapImage.image = UIImage(named:"comp_tottori")
        } else if distanceInt < 3060.4 {
            self.completeMapImage.image = UIImage(named:"comp_okayama")
        } else if distanceInt < 3170.9 {
            self.completeMapImage.image = UIImage(named:"comp_kagawa")
        } else if distanceInt < 3248.4 {
            self.completeMapImage.image = UIImage(named:"comp_tokushima")
        } else if distanceInt < 3316.1 {
            self.completeMapImage.image = UIImage(named:"comp_kouchi")
        } else if distanceInt < 3447.1 {
            self.completeMapImage.image = UIImage(named:"comp_ehime")
        } else if distanceInt < 3650.2 {
            self.completeMapImage.image = UIImage(named:"comp_hiroshima")
        } else if distanceInt < 3766.9 {
            self.completeMapImage.image = UIImage(named:"comp_shimane")
        } else if distanceInt < 3808.0 {
            self.completeMapImage.image = UIImage(named:"comp_yamaguchi")
        } else if distanceInt < 3876.1 {
            self.completeMapImage.image = UIImage(named:"comp_fukuoka")
        } else if distanceInt < 3957.6 {
            self.completeMapImage.image = UIImage(named:"comp_saga")
        } else if distanceInt < 4053.0 {
            self.completeMapImage.image = UIImage(named:"comp_nagasaki")
        } else if distanceInt < 4201.2 {
            self.completeMapImage.image = UIImage(named:"comp_kumamoto")
        } else if distanceInt < 4292.0 {
            self.completeMapImage.image = UIImage(named:"comp_oita")
        } else if distanceInt < 4947.7 {
            self.completeMapImage.image = UIImage(named:"comp_miyazaki")
        } else if distanceInt < 5464.6 {
            self.completeMapImage.image = UIImage(named:"comp_kagoshima")
        } else if distanceInt >= 5464.6 {
            self.completeMapImage.image = UIImage(named:"comp_okinawa")
        }
        
        
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
