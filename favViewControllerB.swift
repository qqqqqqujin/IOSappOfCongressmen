//
//  favViewControllerB.swift
//  csci571
//
//  Created by JIN QU on 01/12/2016.
//  Copyright © 2016 JIN QU. All rights reserved.
//

import UIKit

class favViewControllerB: UIViewController, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UINavigationBarDelegate{

    var searchController = UISearchController()
    
    @IBOutlet weak var rightButton: UIBarButtonItem!
    
    @IBAction func leftButton(_ sender: AnyObject) {
        self.slideMenuController()?.openLeft()
    }
    
    @IBOutlet weak var favTable: UITableView!
    
    @IBAction func searchButton(_ sender: AnyObject) {
        self.searchController = UISearchController(searchResultsController: nil)
        
        if navigationItem.titleView != nil {
            
            searchController.searchBar.isHidden = true
            
            navigationItem.titleView = nil
            rightButton.image = UIImage(named: "Search-50")
            
        }
        else{
            
            
            
            rightButton.image = UIImage(named: "Cancel-50")
            searchController.hidesNavigationBarDuringPresentation = false
            
            searchController.searchResultsUpdater = self
            searchController.dimsBackgroundDuringPresentation = false
            self.searchController.searchBar.delegate = self
            
            
            
            navigationItem.titleView = searchController.searchBar
            
            definesPresentationContext = true
            
        }
        
        self.favTable.reloadData()
        
    }
    
    
    
    
    var filteredarr = [[String:AnyObject]]()
    
    var each = [[String:AnyObject]]()
    
    override func viewWillAppear(_ animated: Bool) {
        self.favTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favTable.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchController.isActive && searchController.searchBar.text != ""{
            return filteredarr.count
        }
        else{
            return billFav.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var dict = [String:AnyObject]()
        
        if self.searchController.isActive && searchController.searchBar.text != ""{
            dict = filteredarr[indexPath.row]
            each = filteredarr
        }
        else{
            dict = billFav[indexPath.row]
            each = billFav
        }
        
        
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "YYYY-MM-DD"
        let showDate = inputFormatter.date(from: (dict["introduced_on"]as? String)!)
        inputFormatter.dateFormat = "DD MMM YYYY"
        let intro = inputFormatter.string(from: showDate!)
        
        let cell = Bundle.main.loadNibNamed("billsTableViewCell", owner: self, options: nil)?.first as? billsTableViewCell
        
        cell?.billTitle.text = (dict["bill_id"] as? String)!
        cell?.official.numberOfLines = 3
        if(dict["official_title"]as? String != nil){
            cell?.official.text = (dict["official_title"] as? String)!
        }
        else{
            cell?.official.text = "N.A."
        }
        cell?.introduce.text = intro
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "favSegueB", sender: each[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let send = segue.destination as! favDetailViewControllerB
        send.mickey = sender as! [String:AnyObject]
    }
    
    
    @IBAction func backTofavB(segue: UIStoryboardSegue){}
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        self.filteredarr.removeAll(keepingCapacity: true)
        
        
        filteredarr = billFav.filter(){
            return ($0["official_title"]as? String != nil)
        }.filter(){
            return ($0["official_title"]as? String)!.lowercased().contains((searchController.searchBar.text?.lowercased())!)
        }
        
        
        self.favTable.reloadData()
    }

    

    

}
