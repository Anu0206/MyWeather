//
//  ViewController.swift
//  MyweatherApp
//
//  Created by admin on 4/19/17.
//  Copyright © 2017 Anuja. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DisplayWeatherViewControllerDelegate {

    let WeekDay:[String] = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    
    
    
    @IBOutlet weak var cityTextField: UITextField!
    var weatherData:[WeatherData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
    @IBAction func getWeatherClicked(_ sender: Any) {
        
        //get weather data from the server
        let readWeatherData = ReadWeatherData()
        
        readWeatherData.readData(city: cityTextField.text!, completionHandler:{(result:[WeatherData]) in
           
            DispatchQueue.main.async {
                print(result)
                self.weatherData = result
                self.callSegue()
            }
            
        })
        
    }
    
    func callSegue(){
        
        performSegue(withIdentifier: "displayWeatherSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "displayWeatherSegue"){
            
           let displayWeatherVC = segue.destination as! DisplayWeatherViewController
            
            let (temp, des) = self.getPresentTemperature()
            
            displayWeatherVC.city = self.cityTextField.text!
            displayWeatherVC.temp = temp
            displayWeatherVC.des = des
            displayWeatherVC.weekDayArray = self.getWeekday()
            displayWeatherVC.delegate = self
            
            //Present the detailVC
            self.present(displayWeatherVC, animated: true, completion: nil)
            
           
 

        }
    }
    
    func getPresentTemperature() -> (Int , String){
        
        let (presentDate, presentTime) = getPresentDateAndTime()
        var temp:Int!
        var des:String!
        
        for i in 0..<self.weatherData.count {
            
            let retrivedDate = weatherData[i].Date
            let retrivedTime = Int(weatherData[i].time)
            
            if(retrivedDate == presentDate){
                
                if(retrivedTime! > Int(presentTime)!){
                    
                    temp = weatherData[i].temperature
                    des = weatherData[i].deiscription
                    
                }
                
            }
            
            
        }
        
        if(temp == nil && des == nil){
            
            temp = 80
            des = "Default"
        }
        
        
        return (temp, des)
    }
    
    func getPresentDateAndTime() -> (String, String){
        let date = Date()
        let dateFormatterDate = DateFormatter()
        let dateFormatterTime = DateFormatter()
        dateFormatterDate.dateFormat = "yyyy-MM-dd"
       dateFormatterTime.dateFormat = "HH"
        let presentDate = dateFormatterDate.string(from: date)
        let presentTime = dateFormatterTime.string(from: date)
        return (presentDate, presentTime)

    }
    
    //MARK:- DetailVC delegate methods
    func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getWeekday() -> [weeklyWeather]{
        
        var finalweeklyReport = [weeklyWeather]()
                let (presentDate, _) = getPresentDateAndTime()
        var i=0
        while (i<self.weatherData.count){
        
        let retrivedDate = weatherData[i].Date
        
        if(retrivedDate != presentDate){

            let weeklyweather = weeklyWeather()
            let weekday = WeekDay[Calendar.current.component(.weekday, from: converStringToDate(date: retrivedDate!)) - 1]
           
            
            weeklyweather.weekDay = weekday
            weeklyweather.minTemp = weatherData[i].minTemperature
            weeklyweather.maxTemp = weatherData[i].maxTemparature
            
            finalweeklyReport.append(weeklyweather)
            i=i+8

            
        }
        else{
            i=i+1
            }
        
        }
        return finalweeklyReport
    }
    
    func converStringToDate(date:String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" //Your date format
        let convertedDate = dateFormatter.date(from: date)
        
        return convertedDate!
    }
    
}

