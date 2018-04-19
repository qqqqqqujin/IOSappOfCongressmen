//
//  senateViewController.swift
//  csci571
//
//  Created by JIN QU on 25/11/2016.
//  Copyright © 2016 JIN QU. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class senateViewController: UIViewController, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    var searchController = UISearchController()
    
    @IBOutlet weak var tblJSON: UITableView!
    
    @IBOutlet weak var rightButton: UIBarButtonItem!
    @IBAction func leftButton(_ sender: UIBarButtonItem) {
        self.slideMenuController()?.openLeft()
    }
    
    var arrRes = [[String:AnyObject]]() //Array of dictionary
    var all = [[String:AnyObject]]()
    var filteredarr = [[String:AnyObject]]()
    var person = [[String:AnyObject]]()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblJSON.delegate = self
        
        Alamofire.request("http://sample-env-1.kkc6kfpbre.us-west-2.elasticbeanstalk.com/", method:.get, parameters:["data":"legislators"]).responseJSON { (responseData) -> Void in
            
            //print("Json: \(responseData.result.value)")
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["results"].arrayObject {
                    //self.arrRes = resData as! [[String:AnyObject]]
                    
                    self.all = resData as! [[String:AnyObject]]
                    
                    self.arrRes = self.all.filter(){
                        return ($0["chamber"]as? String)!.hasPrefix("s")
                    }.sorted(by: {($0["first_name"]as? String)! < ($1["first_name"]as? String)!})
                    
//                    print(self.all.count)
//                    print(self.arrRes.count)
                    
                    
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
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "senatecell")!
        
        var dict = [String:AnyObject]()
        
        if self.searchController.isActive && searchController.searchBar.text != ""{
            dict = filteredarr[indexPath.row]
            person = filteredarr
        }
        else{
            dict = arrRes[indexPath.row]
            person = arrRes
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
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "senateSegue", sender: person[indexPath.row])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let send = segue.destination as! detailViewControllerSenate
        send.mickey = sender as! [String:AnyObject]
    }
    
    @IBAction func backToPrevious3(segue: UIStoryboardSegue){}
    
    func updateSearchResults(for searchController: UISearchController) {
        
        self.filteredarr.removeAll(keepingCapacity: true)
        //        let searchPredicate = NSPredicate(format: "SELF CONTAINS[C] %@", searchController.searchBar.text!)
        //        let array = (self.arrRes as NSArray).filtered(using: searchPredicate)
        //        self.filteredarr = array as! [[String : AnyObject]]
        
        filteredarr = arrRes.filter(){
            return (($0["first_name"]as? String)!+($0["last_name"]as? String)!).lowercased().contains((searchController.searchBar.text?.lowercased())!)
        }
        
        
        self.tblJSON.reloadData()
    }

    
}
