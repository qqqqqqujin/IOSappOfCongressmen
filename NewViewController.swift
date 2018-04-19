//
//  NewViewController.swift
//  csci571
//
//  Created by JIN QU on 28/11/2016.
//  Copyright © 2016 JIN QU. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class NewViewController: UIViewController, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UINavigationBarDelegate{

    
    @IBOutlet weak var rightButton: UIBarButtonItem!
    @IBAction func leftButton(_ sender: AnyObject) {
        self.slideMenuController()?.openLeft()
    }
    
    @IBOutlet weak var tblJSON: UITableView!
    var searchController = UISearchController()
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
    
    
    var arrRes = [[String:AnyObject]]() //Array of dictionary
    var all = [[String:AnyObject]]()
    var filteredarr = [[String:AnyObject]]()
    
    var each = [[String:AnyObject]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblJSON.delegate = self
        
        Alamofire.request("http://sample-env-1.kkc6kfpbre.us-west-2.elasticbeanstalk.com/", method:.get, parameters:["data":"bills_new"]).responseJSON { (responseData) -> Void in
            
            //print("Json: \(responseData.result.value)")
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["results"].arrayObject {
                    //self.arrRes = resData as! [[String:AnyObject]]
                    
                    self.all = resData as! [[String:AnyObject]]
                    
                    self.arrRes = self.all.sorted(by: {($0["introduced_on"]as? String)! > ($1["introduced_on"]as? String)!})
                    
                    //print(self.arrRes)
                    
                }
                if self.arrRes.count > 0 {
                    self.tblJSON.reloadData()
                }
            }
            
        }
        

        
        
        
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
            return self.arrRes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var dict = [String:AnyObject]()
        
        if self.searchController.isActive && searchController.searchBar.text != ""{
            dict = filteredarr[indexPath.row]
            each = filteredarr
        }
        else{
            dict = arrRes[indexPath.row]
            each = arrRes
        }
        
        
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "YYYY-MM-DD"
        let showDate = inputFormatter.date(from: (dict["introduced_on"]as? String)!)
        inputFormatter.dateFormat = "DD MMM YYYY"
        let intro = inputFormatter.string(from: showDate!)
        
        let cell = Bundle.main.loadNibNamed("billsTableViewCell", owner: self, options: nil)?.first as? billsTableViewCell
        
        cell?.billTitle.text = (dict["bill_id"] as? String)!
        cell?.official.numberOfLines = 3
        cell?.official.text = (dict["official_title"] as? String)!
        cell?.introduce.text = intro
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "newSegue", sender: each[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let send = segue.destination as! ditailViewControllerNew
        send.mickey = sender as! [String:AnyObject]
    }
    
    
    @IBAction func backToPreviousNew(segue: UIStoryboardSegue){}
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        self.filteredarr.removeAll(keepingCapacity: true)
        
        filteredarr = arrRes.filter(){
            return ($0["official_title"]as? String)!.lowercased().contains((searchController.searchBar.text?.lowercased())!)
        }
        
        
        self.tblJSON.reloadData()
    }

    

}
