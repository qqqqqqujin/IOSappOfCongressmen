//
//  comDetailViewControllerJ.swift
//  csci571
//
//  Created by JIN QU on 01/12/2016.
//  Copyright © 2016 JIN QU. All rights reserved.
//

import UIKit

class comDetailViewControllerJ: UIViewController,UITableViewDataSource {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollText: UILabel!
    
    var mickey : [String:AnyObject]!
    
    struct detail{
        let cell : Int!
        let left : String!
        let right : String!
    }
    var num = 0
    var index = 0
    var array = [detail]()

    @IBOutlet weak var favStar: UIBarButtonItem!
    
    @IBAction func saveToFav(_ sender: AnyObject) {
        
        
        if(commFav.count != 0){
            for i in 0...commFav.count-1{
                
                if(commFav[i]["committee_id"]as? String == mickey["committee_id"]as? String){
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
            commFav.append(mickey)
            favStar.image = UIImage(named: "Star Filled-50")
            num = 1
        }
        else{
            commFav.remove(at: index)
            favStar.image = UIImage(named: "Star-50")
            num = 0
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(commFav.count != 0){
            for i in 0...commFav.count-1{
                
                if(commFav[i]["committee_id"]as? String == mickey["committee_id"]as? String){
                    
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
        scrollText.numberOfLines = 5
        scrollText.text = mickey["name"]as? String
        
        var office = ""
        if(mickey["office"]as? String == nil){
            office = "N.A."
        }
        else{
            office = (mickey["office"]as? String)!
        }
        
        var contact = ""
        if(mickey["phone"]as? String == nil){
            contact = "N.A."
        }
        else{
            contact = (mickey["phone"]as? String)!
        }
        
        var parent = ""
        if(mickey["phone"]as? String == nil){
            parent = "N.A."
        }
        else{
            parent = (mickey["parent_committee_id"]as? String)!.uppercased()
        }
        
        array = [detail(cell : 1, left : "ID", right : (mickey["committee_id"]as? String)!),
                 detail(cell : 1, left : "Parent ID", right: parent),
                 detail(cell : 1, left : "chamber", right : (mickey["chamber"]as? String)!),
                 
                 detail(cell : 1, left : "Office", right : office),
                 detail(cell : 1, left : "Contact", right : contact)
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
        
        
        let cell = Bundle.main.loadNibNamed("detailTableViewCell1", owner: self, options: nil)?.first as? detailTableViewCell1
        
        cell?.leftText.text = array[indexPath.row].left
        cell?.rightText.text = array[indexPath.row].right
        
        return cell!
        
    }
   

}
