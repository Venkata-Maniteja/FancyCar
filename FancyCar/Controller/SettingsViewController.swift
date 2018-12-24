//
//  SettingsViewController.swift
//  FancyCar
//
//  Created by Venkata on 2018-12-21.
//  Copyright © 2018 Keystroke. All rights reserved.
//

import UIKit


class SettingsViewController: UIViewController {
    
    weak var delegate : SettingsProtocol?
    @IBOutlet weak var settingsList : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        addNavTitle()
        
        settingsList.register(UITableViewCell.self, forCellReuseIdentifier: "settingsCell")
        
    }
    
    func addNavTitle(){
        navigationItem.title = "Sort By"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SettingsViewController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 2{
            return 1
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        
        if indexPath.section == 0{
            cell.textLabel?.text = "Name"
        }else if indexPath.section == 1{
            if indexPath.row == 0{
                cell.textLabel?.text = "In Dealership"
            }else if indexPath.row == 1{
                cell.textLabel?.text = "Unavailable"
            }else{
                cell.textLabel?.text = "Out of Stock"
            }
        }else{
            cell.textLabel?.text = "Remove Sorting"
        }
        
        if UserDefaults.standard.value(forKey: "sortBy") as? String == cell.textLabel?.text{
            cell.accessoryType = .checkmark
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1{
            return "Availability"
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath as IndexPath){
            cell.accessoryType = .checkmark
            if let selectedValue = cell.textLabel?.text{
                if selectedValue == "Remove Sorting"{
                    UserDefaults.standard.removeObject(forKey: "sortBy")
                    delegate?.sortBySelected(sortBy: nil)
                    
                }else{
                    UserDefaults.standard.set(selectedValue, forKey: "sortBy")
                    delegate?.sortBySelected(sortBy: selectedValue)
                    
                }
                UserDefaults.standard.synchronize()
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .none
    }
    
    
}
