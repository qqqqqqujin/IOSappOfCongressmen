//
//  houseViewController.swift
//  csci571
//
//  Created by JIN QU on 25/11/2016.
//  Copyright © 2016 JIN QU. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class houseViewController: UIViewController, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UINavigationBarDelegate{
    
    var searchController = UISearchController()
    
    @IBOutlet weak var tblJSON: UITableView!
    
    @IBOutlet weak var rightButton: UIBarButtonItem!
    
    @IBAction func leftButton(_ sender: UIBarButtonItem) {
        self.slideMenuController()?.openLeft()
    }
//    lazy   var searchBar:UISearchBar = UISearchBar()
//    lazy   var searchBars:UISearchBar = UISearchBar()
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
        
        self.tblJSON.reloadData()
    }
    
//    func didPresentSearchController(searchController: UISearchController) {
//        searchController.searchBar.showsCancelButton = false
//    }
    

    
    var arrRes = [[String:AnyObject]]() //Array of dictionary
    var all = [[String:AnyObject]]()
    var filteredarr = [[String:AnyObject]]()
    
    var each = [[String:AnyObject]]()
    
    var type = ""
    

//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        
//        searchBar.text = nil
//        searchBar.showsCancelButton = false
//        
//        // Remove focus from the search bar.
//        searchBar.endEditing(true)
//        searchController.isActive = false
//        searchController.searchBar.isHidden = true
//        navigationItem.titleView = nil
//        //self.tabBarController?.navigationItem.title = "Legislators"
//    }
    
//    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
//        searchController.searchBar.setShowsCancelButton(false, animated: true)
//        
//        return true
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblJSON.delegate = self

        
        Alamofire.request("http://sample-env-1.kkc6kfpbre.us-west-2.elasticbeanstalk.com/", method:.get, parameters:["data":"legislators"]).responseJSON { (responseData) -> Void in
            
            
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["results"].arrayObject {
                    
                    
                    self.all = resData as! [[String:AnyObject]]
                    
                    self.arrRes = self.all.filter(){
                        return ($0["chamber"]as? String)!.hasPrefix("house")
                    }.sorted(by: {($0["first_name"]as? String)! < ($1["first_name"]as? String)!})
                    
                    
                    
                }
                if self.arrRes.count > 0 {
                    self.tblJSON.reloadData()
                }
            }
            
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "housecell")!
        
        var dict = [String:AnyObject]()
        
        if self.searchController.isActive && searchController.searchBar.text != ""{
            dict = filteredarr[indexPath.row]
            each = filteredarr
        }
        else{
            dict = arrRes[indexPath.row]
            each = arrRes
        }
        
       
        
        let url = NSURL(string: "https://theunitedstates.io/images/congress/225x275/" + (dict["bioguide_id"] as? String)! + ".jpg")
        let data = NSData(contentsOf: url! as URL)
        cell.imageView?.image  = UIImage(data: data! as Data)
        
        cell.textLabel?.text = (dict["first_name"] as? String)! + " " + (dict["last_name"] as? String)!
        cell.detailTextLabel?.text = dict["state_name"] as? String
        
        
        return cell
        
        
    }
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.searchController.isActive && searchController.searchBar.text != ""{
            return filteredarr.count
        }
        else{
            return self.arrRes.count
        }
        
        
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return objectsArray.count
//    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "houseSegue", sender: each[indexPath.row])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let send = segue.destination as! detailViewControllerHouse
        send.mickey = sender as! [String:AnyObject]
    }
    
    @IBAction func backToPrevious2(segue: UIStoryboardSegue){}
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        self.filteredarr.removeAll(keepingCapacity: true)

                filteredarr = arrRes.filter(){
                    return (($0["first_name"]as? String)!+" "+($0["last_name"]as? String)!).lowercased().contains((searchController.searchBar.text?.lowercased())!)
                }

        
        self.tblJSON.reloadData()
    }
    
}

//extension houseViewController : UISearchResultsUpdating{
//    func updateSearchResultsForSearchController(searchController: UISearchController){
//        filterContentForSearchText(searchController.searchBar.text)
//    }
//}
