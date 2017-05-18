//
//  DisplayWeatherViewController.swift
//  MyweatherApp
//
//  Created by admin on 4/19/17.
//  Copyright © 2017 Anuja. All rights reserved.
//

import UIKit

//Mark:- Protocol Declaration
protocol DisplayWeatherViewControllerDelegate {
    func backButtonTapped();
}

class DisplayWeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

   
    @IBOutlet weak var weeklyWeatherReportTable: UITableView!
    @IBOutlet weak var cityLable: UILabel!
    
    @IBOutlet weak var temparatureLable: UILabel!
    
    @IBOutlet weak var descriptionLable: UILabel!
    
    
    var delegate:DisplayWeatherViewControllerDelegate? = nil;
     var weatherData:[WeatherData]!
    var city:String!
    var temp:Int!
    var des:String!
    var weekDayArray:[weeklyWeather]!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.weeklyWeatherReportTable.tableFooterView = UIView(frame: .zero)

        displayData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func displayData(){
        
        cityLable.text = city
        temparatureLable.text = String(temp) + "\u{00B0}" + "F"
        descriptionLable.text = des
        
    }

    //MARK:- IBActions
    @IBAction func backButtonClicked(_ sender: Any) {
        
        delegate?.backButtonTapped()
    }

    //MARK:UITableViewDelegate and DataSource methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "weeksWeather", for: indexPath) as! WeeksWeatherTableViewCell
        
        let report = weekDayArray[indexPath.row] as weeklyWeather
        
        cell.updateLabel(name: report.weekDay, minTemp: String(report.minTemp), maxTemp: String(report.maxTemp))
        
        
        
        return cell
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
   //To set tableview height by numberOfRows
    override func viewDidLayoutSubviews(){
        weeklyWeatherReportTable.frame = CGRect(x: weeklyWeatherReportTable.frame.origin.x, y: weeklyWeatherReportTable.frame.origin.y, width: weeklyWeatherReportTable.frame.size.width, height: weeklyWeatherReportTable.contentSize.height)
        weeklyWeatherReportTable.reloadData()
    }
    
}
