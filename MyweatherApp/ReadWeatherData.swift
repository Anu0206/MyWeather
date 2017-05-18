//
//  ReadWeatherData.swift
//  MyweatherApp
//
//  Created by admin on 4/19/17.
//  Copyright © 2017 Anuja. All rights reserved.
//

import Foundation

class ReadWeatherData{
    
    var weatherdata:WeatherData!
    
    func readData(city:String, completionHandler:@escaping (_ result: [WeatherData]) -> ()){
        var finalWeatherData:[WeatherData]!
        
        //creting URL
        let requestURL = getURL(city: city)
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        
        //ceating session object
        let session = URLSession.shared
        
        //creating a dataTask to read data from the server
        session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            guard error == nil else {
                
                //print("Error: ",error!)
                return
                
            }
            
            do {
                //serializing JSON data
                if let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as? [String:Any]{
                    finalWeatherData = []
                    let list = json["list"] as! NSArray
                    for i in 0..<list.count {
                        
                       self.weatherdata = WeatherData()
                        
                        let arrayData = list[i] as! NSDictionary
                        
                        let temperatureInfo = arrayData["main"] as! NSDictionary
                        let temp = temperatureInfo["temp"] as! Float
                        self.weatherdata.temperature = self.convertKelvinToFahrenheit(tempK: temp)
                        let minTemp = temperatureInfo["temp_min"] as! Float
                        self.weatherdata.minTemperature = self.convertKelvinToFahrenheit(tempK: minTemp)
                        let maxTemp = temperatureInfo["temp_max"] as! Float
                        self.weatherdata.maxTemparature = self.convertKelvinToFahrenheit(tempK: maxTemp)
                        
                        
                        let weatherInfo = arrayData["weather"] as! NSArray
                        let discription = weatherInfo[0] as! NSDictionary
                        self.weatherdata.deiscription = discription["main"] as! String
                        
                        let dateAndTime = arrayData["dt_txt"] as! String
                       let (date,time) = self.splitString(str: dateAndTime, separator: " ")
                        self.weatherdata.Date = date
                        let (hr,_) = self.splitString(str: time, separator: ":")
                        self.weatherdata.time = hr
                            
                        
                        finalWeatherData.append(self.weatherdata)
                        
                    }
                }
                
            } catch let err{
                print(err.localizedDescription)
            }
            
            completionHandler(finalWeatherData)
            }.resume()
    }
    
    func getURL(city:String) -> URL{
    
        //creating the request URL based on the city.
    let str1 =  "http://api.openweathermap.org/data/2.5/forecast?q=".appending(city)
        let finalStr = str1.appending("&APPID=2da3dffb466cf1848a0a1a70e314a7d2")
        
        //to replace escape characters in a string with %20 (URL Encoding)
        let escapedString = finalStr.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
    let finalURL: URL = NSURL(string: escapedString!)! as URL
    
    return finalURL
        
    }
    

    func splitString(str:String, separator:String) -> (date:String , time:String){
        
        let stringAfterSepartion = str.components(separatedBy: separator)
        
        return(stringAfterSepartion[0] , stringAfterSepartion[1])
        
    }
    
    func convertKelvinToFahrenheit(tempK:Float) -> Int{
        
        let tempF = Int((tempK * (9/5)) - 459.67)
        
        return tempF
        
        
    }
}
