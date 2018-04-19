//
//  detailViewControllerHouse.swift
//  csci571
//
//  Created by JIN QU on 28/11/2016.
//  Copyright © 2016 JIN QU. All rights reserved.
//

import UIKit



class detailViewControllerHouse: UIViewController, UITableViewDataSource {

    
    var array = [detail]()
    
    var twitterURL : String!
    var facebookURL : String!
    var webURL : String!
    
    var mickey : [String:AnyObject]!
    
    
    var value = [String]()
    
    @IBOutlet weak var photo: UIImageView!
    
    var num = 0
    var index = 0
    @IBOutlet weak var favStar: UIBarButtonItem!
    
    @IBAction func saveToFav(_ sender: AnyObject) {
        
        
        if(LegiFav.count != 0){
            for i in 0...LegiFav.count-1{
                
                if(LegiFav[i]["bioguide_id"]as? String == mickey["bioguide_id"]as? String){
                    num = 1
                    index = i
                    
                }
                else{
                    num = 0
                }
                
            }
            
        }
        else{
            num = 0
        }
        
        if(num == 0 ){
            LegiFav.append(mickey)
            favStar.image = UIImage(named: "Star Filled-50")
            num = 1
        }
        else{
            LegiFav.remove(at: index)
            favStar.image = UIImage(named: "Star-50")
            num = 0
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(LegiFav.count != 0){
            for i in 0...LegiFav.count-1{
                
                if(LegiFav[i]["bioguide_id"]as? String == mickey["bioguide_id"]as? String){
                    
                    //favStar.image = UIImage(named: "Star Filled-50")
                    num = 1
                    
                }
                
                
            }
            
        }
        
        if(num == 0){
            favStar.image = UIImage(named: "Star-50")
        }
        else{
            favStar.image = UIImage(named: "Star Filled-50")
        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(mickey)
        
        
        //gender
        var gender = ""
        if (mickey["gender"]as? String == "M"){
            gender = "Male"
        }
        else{
            gender = "Female"
        }
        //print(gender)
        
        
        
        //birthday
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "YYYY-MM-DD"
        let showDate = inputFormatter.date(from: (mickey["birthday"]as? String)!)
        inputFormatter.dateFormat = "DD MMM YYYY"
        let birthday = inputFormatter.string(from: showDate!)
        //print(birthday)
        
        
        //chamber
        var chamber = ""
        if(mickey["chamber"]as? String == "house"){
            chamber = "House"
        }
        else{
            chamber = "Senate"
        }
        //print(chamber)
        
        var fax = ""
        if(mickey["fax"]as? String == nil){
            fax = "N.A."
        }
        else{
            fax = (mickey["fax"]as? String)!
        }
        
        
        
        var twitter = ""
        if(mickey["twitter_id"]as? String == nil){
            twitter = "N.A."
            twitterURL = ""
        }
        else{
            twitter = "Twitter Link"
            twitterURL = "https://twitter.com/" + (mickey["twitter_id"]as? String)!
        }
        
        var facebook = ""
        if(mickey["facebook_id"]as? String == nil){
            facebookURL = ""
            facebook = "N.A."
        }
        else{
            facebookURL = "https://www.facebook.com/" + (mickey["facebook_id"]as? String)!
            facebook = "Facebook Link"
        }
        
        
        var website = ""
        if(mickey["website"]as? String == nil){
            webURL = ""
            website = "N.A."
        }
        else{
            webURL = (mickey["website"]as? String)!
            website = "Website Link"
        }
        
        
        let inputformatter = DateFormatter()
        inputformatter.dateFormat = "YYYY-MM-DD"
        let showdate = inputformatter.date(from: (mickey["term_end"]as? String)!)
        inputformatter.dateFormat = "DD MMM YYYY"
        let termEnd = inputformatter.string(from: showdate!)
        
        
        array = [detail(cell : 1, left : "First Name", right : (mickey["first_name"]as? String)!), detail(cell : 1, left : "Last Name", right: (mickey["last_name"]as? String)!), detail(cell : 1, left : "State", right : (mickey["state_name"]as? String)!), detail(cell : 1, left : "Birth date", right : birthday), detail(cell : 1, left : "Gender", right : gender), detail(cell : 1, left : "Chamber", right : chamber), detail(cell : 1, left : "Fax No.", right : fax), detail(cell : 2, left : "Twitter", right : twitter), detail(cell : 4, left : "Facebook", right : facebook), detail(cell : 3, left : "Website", right: website), detail(cell : 1, left : "Office No.", right : (mickey["office"]as? String)!), detail(cell : 1, left : "Term Ends On", right: termEnd)]
        
        
        
        
        
        let url = NSURL(string: "https://theunitedstates.io/images/congress/225x275/" + (mickey["bioguide_id"] as? String)! + ".jpg")
        let data = NSData(contentsOf: url! as URL)
        photo.image  = UIImage(data: data! as Data)
        

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if array[indexPath.row].cell == 1 {
            let cell = Bundle.main.loadNibNamed("detailTableViewCell1", owner: self, options: nil)?.first as? detailTableViewCell1
            
            cell?.leftText.text = array[indexPath.row].left
            cell?.rightText.text = array[indexPath.row].right
            
            return cell!
        }
        else if(array[indexPath.row].cell == 2){
            let cell = Bundle.main.loadNibNamed("detailTableViewCell2", owner: self, options: nil)?.first as? detailTableViewCell2
            
            cell?.leftText.text = array[indexPath.row].left
            cell?.rightText.setTitle(array[indexPath.row].right, for: UIControlState.normal)
            
            cell?.tapAction = { (cell) in
                if let url = NSURL(string: self.twitterURL){
                    UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                }
            }
            
            
            return cell!
        }
        else if(array[indexPath.row].cell == 3){
            let cell = Bundle.main.loadNibNamed("detailTableViewCell2", owner: self, options: nil)?.first as? detailTableViewCell2
            
            cell?.leftText.text = array[indexPath.row].left
            cell?.rightText.setTitle(array[indexPath.row].right, for: UIControlState.normal)
            
            cell?.tapAction = { (cell) in
                if let url = NSURL(string: self.webURL){
                    UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                }
            }
            
            return cell!
        }
        else{
            let cell = Bundle.main.loadNibNamed("detailTableViewCell2", owner: self, options: nil)?.first as? detailTableViewCell2
            
            cell?.leftText.text = array[indexPath.row].left
            cell?.rightText.setTitle(array[indexPath.row].right, for: UIControlState.normal)
            
            cell?.tapAction = { (cell) in
                if let url = NSURL(string: self.facebookURL){
                    UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                }
            }
            
            
            return cell!
        }
        
        
        
    }

    
}
