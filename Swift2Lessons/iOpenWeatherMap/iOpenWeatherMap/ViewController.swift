//
//  ViewController.swift
//  iOpenWeatherMap
//
//  Created by hoangdangtrung on 1/22/16.
//  Copyright © 2016 hoangdangtrung. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var imgMainWeather: UIImageView!
    @IBOutlet weak var labelHumidity: UILabel!
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelWindSpeed: UILabel!
    @IBOutlet weak var labelRainVolume: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var imgBackground = UIImageView()
    var isCheckHiddenTextField: Bool = true
    var isCheckRefreshedInterface: Bool = false
    var arrayItems = [ItemObj]()
    var stringCurrentTextField: String!
    var dictItems = NSMutableDictionary()
    var selectedDate: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 0/256, green: 100/256, blue: 108/256, alpha: 1), NSFontAttributeName: (UIFont.boldSystemFontOfSize(25))] /* Change title text color NavigationBar */
        
        self.imgBackground.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)
        self.imgBackground.layer.zPosition = -1 //bring imageView to behind
        self.imgBackground.alpha = 0.5
        self.imgBackground.image = UIImage(named: "clound.jpg")
        self.view.addSubview(self.imgBackground)
        
        getImformationWeatherWithLocation("Ha noi, Viet nam")
        
    }
    
    // Button labelTemperature
//    @IBAction func refreshWeather(sender: AnyObject) {
//        self.isCheckRefreshedInterface = false
//        self.getImformationWeatherWithLocation(self.stringCurrentTextField)
//    }
    
    @IBAction func btnSearchLocation(sender: UIButton) {
        if isCheckHiddenTextField == true {
            UIView.transitionWithView(self.textField, duration: 0.5, options: UIViewAnimationOptions.TransitionCurlDown, animations: nil, completion: nil)
            self.textField.becomeFirstResponder() //Show keyboard
            self.textField.hidden = false
            isCheckHiddenTextField = false
        } else {
            UIView.transitionWithView(self.textField, duration: 0.5, options: UIViewAnimationOptions.TransitionFlipFromLeft, animations: nil, completion: nil)
            self.textField.resignFirstResponder() // End edit text
            self.textField.hidden = true
            isCheckHiddenTextField = true
        }
    }
    
    /* Text field Delegate */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField.text == "" {
            print("Hello")
        } else {
            self.isCheckRefreshedInterface = false
            self.textField.resignFirstResponder()
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            // Create Animation for TextField Hide/Show
            UIView.transitionWithView(self.textField, duration: 0.5, options: UIViewAnimationOptions.TransitionCurlDown, animations: nil, completion: nil)
            self.textField.hidden = true
            isCheckHiddenTextField = true
            
            self.getImformationWeatherWithLocation(textField.text!)
        }
        
        return true
    }
    
    /* Found location, get data */
    func getImformationWeatherWithLocation(location: String) -> Void {
        self.stringCurrentTextField = location
        
        RequestWeatherData.sharedInstance.getInforWeatherWithLocation(location) { (list: JSON) -> Void in
            let location = list["city"]["name"].rawString()! + ", " + list["city"]["country"].rawString()!
            
            if list == nil {
                print("Error!")
            } else {
                self.arrayItems.removeAll()
                self.dictItems.removeAllObjects()
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                
                for temp in list["list"].arrayValue {
                    //                    print("temp: \(temp)")
                    
                    self.arrayItems.append(ItemObj(temp: temp["main"]["temp"].rawValue as! Float, location: location,date: temp["dt_txt"].rawString()!,
                        mainWeather: temp["weather"][0]["icon"].rawString()!,
                        windSpeed: temp["wind"]["speed"].rawString()!,
                        humidity: temp["main"]["humidity"].rawString()!,
                        rainVolume: temp["rain"]["3h"].rawString()!,
                        description: temp["weather"][0]["description"].rawString()!))
                }
                
                // Refresh Interface with current weather
                if self.arrayItems.count > 0 {
                    for item in self.arrayItems {
                        
                        var arrayItemsForDate: NSMutableArray!
                        if self.dictItems.valueForKey(item.date) != nil {
                            arrayItemsForDate = self.dictItems.valueForKey(item.date) as! NSMutableArray
                            arrayItemsForDate.addObject(item)
                            self.dictItems.setValue(arrayItemsForDate, forKey: item.date)
                        } else {
                            arrayItemsForDate = NSMutableArray(object: item)
                            self.dictItems.setValue(arrayItemsForDate, forKey: item.date)
                        }
                        
                    }
                    self.changeWeatherWithDate(self.getCurrentTime().date)
                }
            }
        }
    }
    
    // Refresh Interface
    func refreshInterface(item: ItemObj) -> Void {
        self.isCheckRefreshedInterface = true
        
        let dayOfWeek: String!
        if self.getDayOfWeek(item.date) == 1 {
            dayOfWeek = "Chủ nhật"
        } else {
            dayOfWeek = "Thứ \(self.getDayOfWeek(item.date))"
        }
        
        // Show time: 2016-01-27 * 06:00
        if item.date == self.getCurrentTime().date {
            if (item.hour == self.getCurrentTime().hour)||(item.hour == "\(Int(self.getCurrentTime().hour)! - 1)")||(item.hour == "\(Int(self.getCurrentTime().hour)! + 1)") {
                self.labelDate.text = dayOfWeek + ", " + item.date + " * " + "\(self.getCurrentTime().time)"
            } else {
                self.labelDate.text = dayOfWeek + ", " + item.date + " * " + item.hour + ":00"
            }
        } else {
            self.labelDate.text = dayOfWeek + ", " + item.date + " * " + item.hour + ":00"
        }
        
        self.imgMainWeather.image = item.imgMainWeather          // Weather icon : http://openweathermap.org/weather-conditions
        
        self.labelTemperature.text = "\(item.temp)"
        if item.temp < 15 {
            self.labelTemperature.textColor = UIColor(red: 32/256, green: 118/256, blue: 212/256, alpha: 1)
        } else if item.temp > 25 {
            self.labelTemperature.textColor = UIColor.redColor()
        } else {
            self.labelTemperature.textColor = UIColor(red: 0/256, green: 100/256, blue: 108/256, alpha: 1)
        }
        
        self.labelDescription.text = item.description
        self.labelHumidity.text = item.humidity
        self.labelRainVolume.text = item.rainVolume
        self.labelWindSpeed.text = item.windSpeed
        self.title = item.location
        
        if (Int(item.hour) > 3)&&(Int(item.hour) < 18) {
            if item.temp > 0 {
                if item.rainVolume != nil {
                    self.imgBackground.image = UIImage(named: "rain.jpg")
                } else {
                    self.imgBackground.image = UIImage(named: "sunCloudy.jpg")
                }
            } else {
                self.imgBackground.image = UIImage(named: "snow.jpg")
            }
        } else if (Int(item.hour) <= 3){
            self.imgBackground.image = UIImage(named: "night6.jpg")
        } else {
            self.imgBackground.image = UIImage(named: "night13.jpg")
        }
        
        
        self.collectionView.reloadData()
        self.tableView.reloadData()
    }
    
    /* Get current time in device */
    func getCurrentTime() -> (hour: String, min: String, time: String, date: String) {
        let calendar = NSCalendar.currentCalendar()
        var hour = String(calendar.component(.Hour,fromDate: NSDate()))
        var minutes = String(calendar.component(.Minute, fromDate: NSDate()))
        let year = String(calendar.component(.Year, fromDate: NSDate()))
        var month = String(calendar.component(.Month, fromDate: NSDate()))
        var day = String(calendar.component(.Day, fromDate: NSDate()))
        
        if Int(month) < 10 {
            month = "0" + month
        }
        if Int(day) < 10 {
            day = "0" + day
        }
        if Int(hour) < 10 {
            hour = "0" + hour
        }
        if Int(minutes) < 10 {
            minutes = "0" + minutes
        }
        
        let date: String = year + "-" + month + "-" + day
        let time: String = hour + ":" + minutes
        return (hour, minutes, time, date)
    }
    
    func getDayOfWeek(today:String)->Int! {
        
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let todayDate = formatter.dateFromString(today) {
            let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
            let myComponents = myCalendar.components(.Weekday, fromDate: todayDate)
            let weekDay = myComponents.weekday
            return weekDay
        } else {
            return nil
        }
    }
    
    // Kiểm tra xem currentTime thuộc khoảng thời gian nào [0;1]=0, [2;3]=3 ...[21;0)=21
    func checkCurrentTime(hour: String) -> String {
        let intHour: Int = Int(hour)!
        var h: Int!
        if (intHour > 21) {
            h = 21
        } else {
            switch intHour % 3 {
            case 0:
                h = intHour
            case 1:
                h = intHour - 1
            default:
                h = intHour + 1
            }
        }
        
        let ok: String
        if h < 10 {
            ok = "0" + "\(h)"
        } else {
            ok = "\(h)"
        }
        return ok
    }
    
    // Update weather with Date
    func changeWeatherWithDate(date: String) -> Void {
        self.selectedDate = date
        
        let arrayItemsForDate = self.dictItems[date] as! NSMutableArray
        
        for item in arrayItemsForDate {
            let itemObj = item as! ItemObj
            if self.isCheckRefreshedInterface == false {
                if itemObj.hour == self.checkCurrentTime(self.getCurrentTime().hour) {
                    self.refreshInterface(itemObj)
                    print("item.date: \(itemObj.date)")
                    print("getCurrentTime: \(self.getCurrentTime().date)")
                    print("item.hour: \(itemObj.hour)")
                    print("CheckCurrentHour:\(self.checkCurrentTime(self.getCurrentTime().hour))")
                }
            }
        }
    }
    
    
    // UICollectionViewDataSource:
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var arrayItemsForDate = NSMutableArray()
        if self.dictItems.count > 0 {
            arrayItemsForDate = self.dictItems[self.selectedDate] as! NSMutableArray
        }
        return arrayItemsForDate.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CellCollectionID", forIndexPath: indexPath) as! CustomCollectionVCell
        
        if self.dictItems.count > 0 {
            let arrayItemsForDate = self.dictItems[self.selectedDate] as! NSMutableArray
            let item = arrayItemsForDate[indexPath.row] as! ItemObj
            
            print("=============\(Int(item.hour)!)==\(Int(self.getCurrentTime().hour)! - 1)")
            if (item.date == self.getCurrentTime().date)&&((item.hour == self.getCurrentTime().hour)||("\(Int(item.hour)!)" == "\(Int(self.getCurrentTime().hour)! - 1)")||("\(Int(item.hour)!)" == "\(Int(self.getCurrentTime().hour)! + 1)")) {
                cell.labelTime24h.text = "now"
                cell.labelTime24h.textColor = UIColor.redColor()
                cell.labelTime24h.font = UIFont.italicSystemFontOfSize(17)
            } else {
                cell.labelTime24h.text = "\(item.hour)" + ":00"
                cell.labelTime24h.font = UIFont.systemFontOfSize(17)
                cell.labelTime24h.textColor = UIColor(red: 127/256, green: 0/256, blue: 127/256, alpha: 1)
            }
            
            cell.labelTemp.text = "\(item.temp)"
            if item.temp > 25 {
                cell.labelTemp.textColor = UIColor.redColor()
            } else if item.temp < 15 {
                cell.labelTemp.textColor = UIColor(red: 32/256, green: 118/256, blue: 212/256, alpha: 1)
            } else {
                cell.labelTemp.textColor = UIColor(red: 0/256, green: 100/256, blue: 108/256, alpha: 1)
            }
            cell.imgWeatherIcon.image = item.imgMainWeather
        }
        return cell
    }
    
    // UICollectionView Delegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if self.dictItems.count > 0 {
            let arrayItemsForDate = self.dictItems[self.selectedDate] as! NSMutableArray
            let item = arrayItemsForDate[indexPath.row] as! ItemObj
            self.refreshInterface(item)
        }
    }
    
    //------------------------------------------------------
    
    // Table View Data Source:
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dictItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellTableView", forIndexPath: indexPath) as! CustomCellTableView
        
        if self.dictItems.count > 0 {
            //            let arrayItemsForDate = self.dictItems[self.selectedDate] as! NSMutableArray
            //            let item = arrayItemsForDate[indexPath.row] as! ItemObj
            var arrayDate = self.dictItems.allKeys as NSArray
            arrayDate = arrayDate.sortedArrayUsingSelector("compare:")
            
            cell.labelDate.text = arrayDate[indexPath.row] as? String
            if cell.labelDate.text == self.getCurrentTime().date {
                cell.labelToday.hidden = false
            } else {
                cell.labelToday.hidden = true
            }
            
            // Get Min/Max Temperature
            let arrayForDate = self.dictItems[cell.labelDate.text!] as! NSArray
            var arrayTempForDate = [Int]()
            for item in arrayForDate {
                let itemObj = item as! ItemObj
                arrayTempForDate.append(Int(itemObj.temp))
            }
            
            cell.labelTempMin.text = "\(arrayTempForDate.minElement()!)"
            cell.labelTempMax.text = "\(arrayTempForDate.maxElement()!)"
        }
        
        return cell
    }
    
    //Table View Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath) as! CustomCellTableView
        let date = selectedCell.labelDate.text
        
        self.isCheckRefreshedInterface = false
        self.changeWeatherWithDate(date!)
    }
    
    
}












