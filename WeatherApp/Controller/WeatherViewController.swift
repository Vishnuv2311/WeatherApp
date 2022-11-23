//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Vishnu V on 12/11/22.
//

import UIKit
import CoreLocation
import CoreData

class WeatherViewController: UIViewController ,CLLocationManagerDelegate,CustomLocationDelegate{
    
    var locationData:CLLocation!
    
    var locationManager:CLLocationManager!
    
    var callOnce:Bool = false
    
    var userLat: Double = 51.5085
    var userLon: Double = -0.1257
   
    @IBOutlet weak var tempTxt: UILabel!
    
    @IBOutlet weak var locationTxt: UILabel!
    
    @IBOutlet weak var locationMsgTxt: UILabel!
    
    @IBOutlet weak var humidityTxt: UILabel!
    
    @IBOutlet weak var windSpeedTxt: UILabel!
    
    @IBOutlet weak var maxTempTxt: UILabel!
    
    @IBOutlet weak var minTempTxt: UILabel!
    
    @IBOutlet weak var weatherMsgTxt: UILabel!
    
    var persistentContainer: NSPersistentContainer!
    
    var appDelegate: AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        persistentContainer = appDelegate.persistentContainer
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
        
    

        // Do any additional setup after loading the view.
    }
    
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func currentLocationPress(_ sender: Any) {
        callOnce = false
    }
    
    @IBAction func cityNamePress(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let favController = storyboard.instantiateViewController(withIdentifier: "FavoritesViewController") as? FavoritesViewController
                else {return}
        favController.delegate = self
        self.navigationController?.pushViewController(favController, animated: true)
        

        
    }
    
    func didSelectLocation(location: String) {
        WeatherApi.getCityWeather(cityName: location) { response, error in
            
            if let response = response{
                self.updateUi(data: response)
            }else{
                DispatchQueue.main.async {
//                    self.showOKAlert(error: error?.localizedDescription)
                }
            }
        }
    }
    
    
    //MARK: - Call Api
    
    func fetchCurrentLocationWeather(){
        
        
        WeatherApi.getLocationWeather(latitude: userLat, longitude: userLon) { response, error in
            if let response = response {
                DispatchQueue.main.async {
                    self.updateUi(data:response)
                }
                
            } else {
                DispatchQueue.main.async {
//                    self.showOKAlert(error: error?.localizedDescription)
                    
                }
                }
        }
       

        
    }
    
    
    func updateUi(data:WeatherResponse){

        self.tempTxt.text = "\(data.main.temp) \(data.getWeatherIcon())"
        self.locationTxt.text = data.name
        self.locationMsgTxt.text = data.weather?[0].weatherDescription ?? ""
        self.humidityTxt.text = "\(data.main.humidity ?? 0)"
        self.windSpeedTxt.text = "\(data.wind?.speed ?? 0)"
        self.maxTempTxt.text = "\(data.main.tempMax)"
        self.minTempTxt.text = "\(data.main.tempMin)"
        self.weatherMsgTxt.text = data.getMessage()
        
        
        let fetchRequest:NSFetchRequest<Location> = NSFetchRequest(entityName: "Location")
        do{
           let favLocations = try persistentContainer.viewContext.fetch(fetchRequest)
    
            let filterdList = favLocations.filter{$0.cityName ==
                data.name}
            if(filterdList.isEmpty){
              
                var newLocation  =  Location(context: persistentContainer.viewContext)
                newLocation.cityName = data.name
                newLocation.favorite = false
                
                
                
                appDelegate.saveContext()
            }
            
        }catch {
            showOKAlert(title: "Error",message: "No data found")
        }
        
       
        
        
        
    }
    
    
    
    //MARK: - Location
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty {
            let userLocation: CLLocation = locations[0] as CLLocation
            
            print("User latitude: \(userLocation.coordinate.latitude)")
            print("User longitude: \(userLocation.coordinate.longitude)")
            
            userLat = userLocation.coordinate.latitude
            userLon = userLocation.coordinate.longitude
            
            if !callOnce{
                fetchCurrentLocationWeather()
                callOnce = true
                locationManager.stopUpdatingLocation()
            }
            
        }
        
    }
    


}
