//
//  FavoritesViewController.swift
//  WeatherApp
//
//  Created by Vishnu V on 12/11/22.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController {
    
    var delegate: CustomLocationDelegate?
    
    var favLocations:[Location] = []
    
    var persistentContainer: NSPersistentContainer!
    
    var favoriteCellPath: IndexPath? = nil
    
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var cityNameTextField: UITextField!
    
    @IBOutlet weak var recentSearchTable: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        recentSearchTable.delegate = self
        recentSearchTable.dataSource = self
        
        cityNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        persistentContainer = appDelegate.persistentContainer
        
        fetchRechtLocations()

    }
    
    @IBAction func getWeatherPress(_ sender: Any) {
        if(cityNameTextField.text?.isEmpty == true){
            showOKAlert(title: "Location Error",message:  "Location is Empty")
        }else{
            delegate?.didSelectLocation(location: cityNameTextField.text!)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func fetchRechtLocations(){
        let fetchRequest:NSFetchRequest<Location> = NSFetchRequest(entityName: "Location")
        do{
            favLocations = try persistentContainer.viewContext.fetch(fetchRequest)
            self.recentSearchTable.reloadData()
        }catch {
            showOKAlert(title: "Error",message: "No data found")
        }
        
    }
    
    @objc
    func textDidChange(){
        let text = cityNameTextField.text
        searchBtn.isHidden = text?.isEmpty ?? false
    }

}


protocol CustomLocationDelegate{
    func didSelectLocation(location : String)
}


//MARK: -

extension FavoritesViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecentSearchTableViewCell",for: indexPath)
              as? RecentSearchTableViewCell
        else {return UITableViewCell()}
        
        cell.lableCity.text = favLocations[indexPath.row].cityName
        
        if favLocations[indexPath.row].favorite {
            cell.favIcon?.image = UIImage(systemName: "star.fill")
            favoriteCellPath = indexPath
        } else {
            cell.favIcon?.image = UIImage(systemName: "star")
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if favoriteCellPath != nil || favoriteCellPath == indexPath {
            if favoriteCellPath == indexPath {
                favLocations[indexPath.row].favorite = false
                favoriteCellPath = nil
                tableView.reloadRows(at: [indexPath], with: .automatic)
            } else {
                favLocations[favoriteCellPath!.row].favorite = false
                favLocations[indexPath.row].favorite = true
                tableView.reloadRows(at: [indexPath, favoriteCellPath!], with: .automatic)
                favoriteCellPath = indexPath
            }
        } else {
            favLocations[indexPath.row].favorite = true
            favoriteCellPath = indexPath
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        try? persistentContainer?.viewContext.save()
        
        delegate?.didSelectLocation(location: favLocations[indexPath.row].cityName ?? "")
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
}
