//
//  ViewController.swift
//  WeekDisplaySample
//
//  Created by Ryo Endo on 2018/06/30.
//  Copyright © 2018年 Ryo Endo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var weekLabel: UILabel!
    var baseDate: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let now = Date()
        let calendar = Calendar.current
        let startDay = calendar.startOfWeek(for: now)
        
      
        
        baseDate = startDay
        
        weekLabel.text = getDay(date: startDay) + "(" +  startDay.weekday + ")" + "の週"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //任意の日付をとる
    func getDay(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MM/dd", options: 0, locale: Locale(identifier: "ja_JP"))
        return formatter.string(from: date)
    }
    
    
    /**
     　　n週間後(前)の日付を取得
     - parameter week: n(週)
     - returns: 算出後の日付
     */
    func getDateBeforeOrAfterSomeWeek(week:Double) -> Date {
        var resultDate:Date
        
        if week > 0 {
            resultDate = Date(timeInterval: 604800*week, since: baseDate as Date)
        } else {
            resultDate = Date(timeInterval: -604800*fabs(week), since: baseDate as Date)
        }
        return resultDate
    }
    
    
    
    @IBAction func nextWeekButton() {
        baseDate = getDateBeforeOrAfterSomeWeek(week: 1)
        weekLabel.text = getDay(date: baseDate) + "(" +  baseDate.weekday + ")" + "の週"
        
    }
    
    @IBAction func previoustWeekButton() {
        baseDate = getDateBeforeOrAfterSomeWeek(week: -1)
        weekLabel.text = getDay(date: baseDate) + "(" +  baseDate.weekday + ")" + "の週"
    }
    
    
    
}






extension Date {
    
    //曜日をとる
    var weekday: String {
        let calendar = Calendar(identifier: .gregorian)
        let component = calendar.component(.weekday, from: self)
        let weekday = component - 1
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja")
        return formatter.weekdaySymbols[weekday].replacingOccurrences(of:"曜日", with:"")
    }
}

extension Calendar {
    //週の初めの日付
    func startOfWeek(for date:Date) -> Date {
        let comps = self.dateComponents([.weekOfYear, .yearForWeekOfYear], from: date)
        return self.date(from: comps)!
    }
    
    
    
}
