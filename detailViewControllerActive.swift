//
//  detailViewControllerActive.swift
//  csci571
//
//  Created by JIN QU on 29/11/2016.
//  Copyright © 2016 JIN QU. All rights reserved.
//

import UIKit

var billFav : [[String:AnyObject]]! = []

class detailViewControllerActive: UIViewController, UITableViewDataSource {

    var mickey : [String:AnyObject]!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollText: UILabel!
    
    struct detail{
        let cell : Int!
        let left : String!
        let right : String!
    }
    var num = 0
    var index = 0
    var array = [detail]()
    var pdfURL : String!
    
    @IBOutlet weak var favStar: UIBarButtonItem!
    
    @IBAction func saveToFav(_ sender: AnyObject) {
        
        
        if(billFav.count != 0){
            for i in 0...billFav.count-1{
                
                if(billFav[i]["bill_id"]as? String == mickey["bill_id"]as? String){
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
            billFav.append(mickey)
            favStar.image = UIImage(named: "Star Filled-50")
            num = 1
        }
        else{
            billFav.remove(at: index)
            favStar.image = UIImage(named: "Star-50")
            num = 0
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(billFav.count != 0){
            for i in 0...billFav.count-1{
                
                if(billFav[i]["bill_id"]as? String == mickey["bill_id"]as? String){
                    
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
        
        scrollView.contentSize.height = 250
        //scrollText.lineBreakMode = .byWordWrapping
        scrollText.numberOfLines = 10
        scrollText.text = mickey["official_title"]as? String
        
        var sponsor : String!
        sponsor = (mickey["sponsor"]?["title"]as? String)! + " " + (mickey["sponsor"]?["first_name"]as? String)! + " " + (mickey["sponsor"]?["last_name"]as? String)!
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "YYYY-MM-DD"
        let showDate = inputFormatter.date(from: (mickey["last_action_at"]as? String)!)
        inputFormatter.dateFormat = "DD MMM YYYY"
        let action = inputFormatter.string(from: showDate!)
        
        var chamber = ""
        if(mickey["chamber"]as? String == "house"){
            chamber = "House"
        }
        else{
            chamber = "Senate"
        }
        
        var vote = ""
        if(mickey["last_vote_at"]as? String == nil){
            vote = "N.A."
        }
        else{
            let inputFormatter1 = DateFormatter()
            inputFormatter1.dateFormat = "YYYY-MM-DD"
            let showDate1 = inputFormatter1.date(from: (mickey["last_vote_at"]as? String)!)
            inputFormatter1.dateFormat = "DD MMM YYYY"
            vote = inputFormatter.string(from: showDate1!)
        }
        
        
        var pdf = "N.A."
        if(mickey["bill_id"]as? String == "sres617-114"){
            pdf = "PDF Link"
            pdfURL = "https://www.gpo.gov/fdsys/pkg/BILLS-114sres617ats/pdf/BILLS-114sres617ats.pdf"
        }
        if(mickey["bill_id"]as? String == "sres576-114"){
            pdf = "PDF Link"
            pdfURL = "https://www.gpo.gov/fdsys/pkg/BILLS-114sres576ats/pdf/BILLS-114sres576ats.pdf"
        }
        if(mickey["bill_id"]as? String == "sres557-114"){
            pdf = "PDF Link"
            pdfURL = "https://www.gpo.gov/fdsys/pkg/BILLS-114sres557ats/pdf/BILLS-114sres557ats.pdf"
        }
        
        //print(mickey)
//        if(mickey["last_version"] == nil){
//            pdf = "N.A."
//            pdfURL = ""
//        }
//        else{
//            pdf = "PDF Link"
//            pdfURL = (mickey["last_version"]?["urls"]?["pdf"]as? String)!
//        }
        
        
        array = [detail(cell : 1, left : "Bill ID", right : (mickey["bill_id"]as? String)!),
                 detail(cell : 1, left : "Bill Type", right: (mickey["bill_type"]as? String)!.uppercased()),
                 detail(cell : 1, left : "Sponsor", right : sponsor),
                 detail(cell : 1, left : "Last Action", right : action),
            detail(cell : 2, left : "PDF", right : pdf),
            detail(cell : 1, left : "Chamber", right : chamber),
            detail(cell : 1, left : "Last Vote", right : vote),
            detail(cell : 1, left : "Status", right : "Active")
                ]
        
        
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
        else{
            let cell = Bundle.main.loadNibNamed("detailTableViewCell2", owner: self, options: nil)?.first as? detailTableViewCell2
            
            cell?.leftText.text = array[indexPath.row].left
            cell?.rightText.setTitle(array[indexPath.row].right, for: UIControlState.normal)
            
            cell?.tapAction = { (cell) in
                if let url = NSURL(string: self.pdfURL){
                    UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                }
            }
            return cell!
        }
        
        
    }
   
}
