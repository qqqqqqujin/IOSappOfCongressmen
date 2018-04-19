//
//  favViewControllerL.swift
//  csci571
//
//  Created by JIN QU on 01/12/2016.
//  Copyright © 2016 JIN QU. All rights reserved.
//

import UIKit

class favViewControllerL: UIViewController, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UINavigationBarDelegate{

    @IBAction func leftButton(_ sender: UIBarButtonItem) {
        self.slideMenuController()?.openLeft()
    }
    
    var searchController = UISearchController()
    
    var filteredarr = [[String:AnyObject]]()
    var each = [[String:AnyObject]]()
    
    @IBOutlet weak var favTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.favTable.delegate = self
        
        //tableView.reloadData()
        print("fav:\(LegiFav)")
    }

    @IBOutlet weak var rightButton: UIBarButtonItem!
    
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
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.favTable.reloadData()
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
            
            return LegiFav.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "favcell")!
        
        var dict : [String: AnyObject]!
        
        if self.searchController.isActive && searchController.searchBar.text != ""{
            dict = filteredarr[indexPath.row]
            each = filteredarr
        }
        else{
            dict = LegiFav[indexPath.row]
            each = LegiFav
        }
        
        
        
        let url = NSURL(string: "https://theunitedstates.io/images/congress/225x275/" + (dict["bioguide_id"] as? String)! + ".jpg")
        let data = NSData(contentsOf: url! as URL)
        cell.imageView?.image  = UIImage(data: data! as Data)
        
        cell.textLabel?.text = (dict["first_name"] as? String)! + " " + (dict["last_name"] as? String)!
        cell.detailTextLabel?.text = dict["state_name"] as? String
        //self.favTable.reloadData()
        
        return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "favSegueL", sender: each[indexPath.row])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let send = segue.destination as! favDetailViewControllerL
        send.mickey = sender as! [String:AnyObject]
    }
    
    @IBAction func backTofavL(segue: UIStoryboardSegue){}
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        self.filteredarr.removeAll(keepingCapacity: true)
        
        filteredarr = LegiFav.filter(){
            return (($0["first_name"]as? String)!+" "+($0["last_name"]as? String)!).lowercased().contains((searchController.searchBar.text?.lowercased())!)
        }
        
        
        self.favTable.reloadData()
    }

}
