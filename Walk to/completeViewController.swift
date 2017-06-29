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

    override func viewDidLoad() {
        super.viewDidLoad()

        let now = Date()
        let jaLocale = Locale(identifier: "ja_JP")
        
        let df = DateFormatter()
        df.dateFormat = "yyyy年MM月dd日"
        myDate.text = df.string(from: now)
        
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
