//
//  ViewController.swift
//  FancyCar
//
//  Created by Keystroke on 2018-12-20.
//  Copyright © 2018 Keystroke. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var spinner: Spinner!
    @IBOutlet weak var downLoadBtn: FancyButton!
    @IBOutlet weak var splashView: UIImageView!
    @IBOutlet weak var listView: UITableView!
    
    var cars : [RLMCar]?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //setting delegate for car manager
        CarManager.shared.delegate = self
        
        //observe the network changes, andupdate user when no network is avilablble
        startObservingNetworkChanges()
        
        //preparing the list view
        prepareListView()
        
        //starting the splash anmation.
        startSplashAnimation()
        
        //adding the sort button to the nav bar
        showSortbutton()
    }
    
    func startSplashAnimation(){
        
        hideNavBar()
        downLoadBtn.isHidden = true
        
        //splash animation
        splashView.animationDuration = 1.0
        splashView.animationImages = [UIImage(named: "icon_car_purple"),UIImage(named: "icon_car_yellow"),UIImage(named: "icon_car_red"),UIImage(named: "icon_car_green"),UIImage(named: "icon_car_pink")] as? [UIImage]
        splashView.startAnimating()
        
        //initialising cars array
        cars = [RLMCar]()
        
        //This is not needed in general. I used this delay to simulate the time taken by REST api to get the cars data and process it
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.splashView.isHidden = true
            self.showNavBar()
            //sorting the data based on user selection
            if let sortBy = UserDefaults.standard.object(forKey: "sortBy") as? String{
                self.sortBySelected(sortBy:sortBy)
            }else{
                self.sortBySelected(sortBy:nil)
            }
        
            //update UI based on the downlaoded cars count
            if let count = self.cars?.count{
                self.downLoadBtn.isHidden = (count > 0)
                self.listView.isHidden = !(count > 0)
            }else{
                self.downLoadBtn.isHidden = false
            }
            self.listView.reloadData()
        })
    
    }
    
    //Show the right button only when there is data available for display
    func showSortbutton(){
        var image = UIImage(named: "icon_sort")
        image = image?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style:.plain, target: self, action: #selector(sortButtonClicked))
    }
    
    func prepareListView(){
        listView.isHidden = true
        listView.separatorColor = listView.backgroundColor
        listView.register(UINib(nibName: "CarCell", bundle: Bundle.main), forCellReuseIdentifier: "carCell")
    }
    
    @objc func sortButtonClicked(){
        let vc = SettingsViewController.init(nibName: "SettingsViewController", bundle: Bundle.main)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: Reachabaility methods - end
    @IBAction func downloadCars(sender: UIButton){
        
        //animate the button
        sender.animateClick()
        
        //Download only when network is available
        if isNetworkAvailable() == false{
            showFancyAlert(title: "No network", msg: "Unable to download :(! Please try after connecting to a network.", icon:"icon_no_wifi")
        }else{
            sender.isHidden = true
            spinner.showSpinner()
            
            //downlaod cars
            CarManager.shared.getCarsFromJSON()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                self.loadCarsTable()
            })
        }
    }
    
    func loadCarsTable(){
        spinner.hideSpinner()
        listView.isHidden = false
        listView.reloadData()
    }
    
    func getNextPageResults(){
        CarManager.shared.getCarsFromJSON()
    }

}

//table delegate and datasource
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let count = cars?.count else {
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "carCell", for: indexPath) as! CarCell
        guard let car = cars?[indexPath.section] else {
            return cell
        }
        configureCell(cell: cell, car: car)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if let car = cars?[indexPath.section]{
            if car.available == "In Dealership"{
                showFancyAlert(title: "Available", msg: "Do you want to buy this?", icon: "icon_buy")
            }else{
                showFancyAlert(title: "Unavailable", msg: "Sorry this is not available at this moment.", icon: "icon_unavailable")
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    
    //customising the cell
    func configureCell(cell:CarCell, car:RLMCar){
        
        cell.name.text = car.name
        cell.make.text = car.make
        cell.model.text = car.model
        cell.year.text = car.year
        cell.iconV.image = UIImage(named: car.icon)
        cell.selectionStyle = .none
        //CarManager.shared.isCarAvailable(rlmCar: car)
        if  car.available == "In Dealership"{
            cell.availableIconV.image = UIImage(named: "icon_available")
            cell.buyIcon.isHidden = false
        }else{
            cell.availableIconV.image = UIImage(named: "icon_unavailable")
            cell.buyIcon.isHidden = true
        }
       
    }
    
    
}

extension ViewController : UIScrollViewDelegate{
    
    //This gets called while list view is scrolling
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let  height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            
           //This is the end of the list, get the new page data and reload the list
           getNextPageResults()
        }
    }
}

extension ViewController : CarDelegate{
   
    //This gets called when the cars been downloaded and ready to be updated on theliast view
    func carsUpdated() {
        //If a sortBy is sleected, sort the new results based on that
        if let sortBy = UserDefaults.standard.object(forKey: "sortBy") as? String{
            self.sortBySelected(sortBy:sortBy)
        }else{
            self.sortBySelected(sortBy:nil)
        }
        listView.reloadData()
    }
}

extension ViewController : SettingsProtocol{
    
    //This gets called when user selected the sort options
    func sortBySelected(sortBy: String?) {
        
        if sortBy == "Name"{
           cars = CarManager.shared.getCars(sortBy: "name")
        }else{
            cars = CarManager.shared.getCars(sortBy: nil)
            if let sortBy = sortBy{
                if var temp = cars{
                    //sort result based on the available key
                    temp = temp.filter({$0.available == sortBy})
                    temp = temp.sorted(by: { $0.available > $1.available })
                    cars = temp
                }
            }
        }
        listView.reloadData()
    }
}
