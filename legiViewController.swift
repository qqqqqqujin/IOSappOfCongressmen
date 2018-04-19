//
//  ViewController.swift
//  csci571
//
//  Created by JIN QU on 20/11/2016.
//  Copyright © 2016 JIN QU. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

struct Objects{
    var sectionName: String!
    var sectionObjects: [[String:AnyObject]]!
}


class legiViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBAction func filterButton(_ sender: AnyObject) {
        self.tblJSON.isHidden = true
        self.picker.isHidden = false
        
    }
    
    @IBOutlet weak var picker: UIPickerView!
    
    
    @IBAction func leftButton(_ sender: UIBarButtonItem) {
            self.slideMenuController()?.openLeft()
    }
    
    @IBOutlet weak var tblJSON: UITableView!
    var arrRes = [[String:AnyObject]]() //Array of dictionary
    var constentarrRes = [[String:AnyObject]]()
    
    var selectedState = ""
    
    var objectsArray = [Objects]()
    
    var arrIndexSection = ["A","B","C","D", "E", "F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    var states = ["All States","Alabama","Alaska","Arkansas","American Samoa","Arizona","California","Colorado","Connecticut","Delaware","District Of Columbia","Florida","Georgia","Guam","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Kouisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Northern Mariana Islands","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Puerto Rico","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Virginia","US Virgin Islands","Vermont","Washington","Wisconsin","West Virginia","Wyoming"]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//         Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.isNavigationBarHidden = true
        
        picker.delegate = self
        picker.dataSource = self
        
        tblJSON.delegate = self 
        
        Alamofire.request("http://sample-env-1.kkc6kfpbre.us-west-2.elasticbeanstalk.com/", method:.get, parameters:["data":"legislators"]).responseJSON { (responseData) -> Void in
       
            //print("Json: \(responseData.result.value)")
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["results"].arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                    
                    self.constentarrRes = resData as! [[String:AnyObject]]
                    
                    let sectionA = self.arrRes.filter(){
                        return ($0["first_name"]as? String)!.hasPrefix("A")
                        }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
                    //print("sectionA: \(sectionA)")
                    let sectionB = self.arrRes.filter(){
                        return ($0["first_name"]as? String)!.hasPrefix("B")
                        }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
                    //print("sectionB: \(sectionB)")
                    let sectionC = self.arrRes.filter(){
                        return ($0["first_name"]as? String)!.hasPrefix("C")
                        }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
                    //print("sectionC: \(sectionC)")
                    let sectionD = self.arrRes.filter(){
                        return ($0["first_name"]as? String)!.hasPrefix("D")
                        }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
                    
                    let sectionE = self.arrRes.filter(){
                        return ($0["first_name"]as? String)!.hasPrefix("E")
                        }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
                    
                    let sectionF = self.arrRes.filter(){
                        return ($0["first_name"]as? String)!.hasPrefix("F")
                        }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
                    
                    let sectionG = self.arrRes.filter(){
                        return ($0["first_name"]as? String)!.hasPrefix("G")
                        }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
                    
                    let sectionH = self.arrRes.filter(){
                        return ($0["first_name"]as? String)!.hasPrefix("H")
                        }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
                    
                    let sectionI = self.arrRes.filter(){
                        return ($0["first_name"]as? String)!.hasPrefix("I")
                        }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
                    
                    let sectionJ = self.arrRes.filter(){
                        return ($0["first_name"]as? String)!.hasPrefix("J")
                        }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
                    
                    let sectionK = self.arrRes.filter(){
                        return ($0["first_name"]as? String)!.hasPrefix("K")
                        }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
                    
                    let sectionL = self.arrRes.filter(){
                        return ($0["first_name"]as? String)!.hasPrefix("L")
                        }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
                    
                    let sectionM = self.arrRes.filter(){
                        return ($0["first_name"]as? String)!.hasPrefix("M")
                        }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
                    
                    let sectionN = self.arrRes.filter(){
                        return ($0["first_name"]as? String)!.hasPrefix("N")
                        }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
                    
                    let sectionO = self.arrRes.filter(){
                        return ($0["first_name"]as? String)!.hasPrefix("O")
                        }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
                    
                    let sectionP = self.arrRes.filter(){
                        return ($0["first_name"]as? String)!.hasPrefix("P")
                        }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
                    
                    let sectionQ = self.arrRes.filter(){
                        return ($0["first_name"]as? String)!.hasPrefix("Q")
                        }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
                    
                    let sectionR = self.arrRes.filter(){
                        return ($0["first_name"]as? String)!.hasPrefix("R")
                        }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
                    
                    let sectionS = self.arrRes.filter(){
                        return ($0["first_name"]as? String)!.hasPrefix("S")
                        }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
                    
                    let sectionT = self.arrRes.filter(){
                        return ($0["first_name"]as? String)!.hasPrefix("T")
                        }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
                    
                    let sectionU = self.arrRes.filter(){
                        return ($0["first_name"]as? String)!.hasPrefix("U")
                        }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
                    
                    let sectionV = self.arrRes.filter(){
                        return ($0["first_name"]as? String)!.hasPrefix("V")
                        }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
                    
                    let sectionW = self.arrRes.filter(){
                        return ($0["first_name"]as? String)!.hasPrefix("W")
                        }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
                    
                    let sectionX = self.arrRes.filter(){
                        return ($0["first_name"]as? String)!.hasPrefix("X")
                        }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
                    
                    let sectionY = self.arrRes.filter(){
                        return ($0["first_name"]as? String)!.hasPrefix("Y")
                        }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
                    
                    let sectionZ = self.arrRes.filter(){
                        return ($0["first_name"]as? String)!.hasPrefix("Z")
                        }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
                    

                    self.objectsArray = [Objects(sectionName:"A", sectionObjects:sectionA), Objects(sectionName:"B", sectionObjects:sectionB), Objects(sectionName:"C", sectionObjects:sectionC), Objects(sectionName:"D", sectionObjects:sectionD), Objects(sectionName:"E", sectionObjects:sectionE), Objects(sectionName:"F", sectionObjects:sectionF), Objects(sectionName:"G", sectionObjects:sectionG), Objects(sectionName:"H", sectionObjects:sectionH), Objects(sectionName:"I", sectionObjects:sectionI), Objects(sectionName:"J", sectionObjects:sectionJ), Objects(sectionName:"K", sectionObjects:sectionK), Objects(sectionName:"L", sectionObjects:sectionL), Objects(sectionName:"M", sectionObjects:sectionM), Objects(sectionName:"N", sectionObjects:sectionN), Objects(sectionName:"O", sectionObjects:sectionO), Objects(sectionName:"P", sectionObjects:sectionP), Objects(sectionName:"Q", sectionObjects:sectionQ), Objects(sectionName:"R", sectionObjects:sectionR), Objects(sectionName:"S", sectionObjects:sectionS), Objects(sectionName:"T", sectionObjects:sectionT), Objects(sectionName:"U", sectionObjects:sectionU), Objects(sectionName:"V", sectionObjects:sectionV), Objects(sectionName:"W", sectionObjects:sectionW), Objects(sectionName:"X", sectionObjects:sectionX), Objects(sectionName:"Y", sectionObjects:sectionY), Objects(sectionName:"Z", sectionObjects:sectionZ)]
                    //print("array: \(self.objectsArray)")
                    
                }
                if self.arrRes.count > 0 {
                    self.tblJSON.reloadData()
                }
            }
            
        }
        
        
    }

    //var data = [Objects]()
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        
        
        var dict = objectsArray[indexPath.section].sectionObjects[indexPath.row]
        
        let url = NSURL(string: "https://theunitedstates.io/images/congress/225x275/" + (dict["bioguide_id"] as? String)! + ".jpg")
        let data = NSData(contentsOf: url! as URL)
        cell.imageView?.image  = UIImage(data: data! as Data)
        
        cell.textLabel?.text = (dict["first_name"] as? String)! + " " + (dict["last_name"] as? String)!
        cell.detailTextLabel?.text = dict["state_name"] as? String

        
        return cell
        

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return objectsArray[section].sectionName
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectsArray[section].sectionObjects.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return objectsArray.count
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        var tempIndex:Int = 0
        for str in arrIndexSection {
            if str == title {
                return tempIndex
            }
            tempIndex += 1
        }
        return 0
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return arrIndexSection
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "stateDetailSegue", sender: objectsArray[indexPath.section].sectionObjects[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let send = segue.destination as! detailViewControllerState
        send.mickey = sender as! [String:AnyObject]
    }
    
    @IBAction func backToPrevious(segue: UIStoryboardSegue){}
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return states[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        tblJSON.isHidden = true
        self.selectedState = states[row]
        
        
        let fstates = self.constentarrRes.filter(){
            
            
            if (self.selectedState == "All States"){
                
                return ($0["state_name"]as? String)!.hasPrefix("")
                
            } else {
                
                return ($0["state_name"]as? String)!.hasPrefix(self.selectedState)
                
            }
        }
        
        if(self.selectedState == "All States"){
            
            
            
            let sectionA = self.arrRes.filter(){
                return ($0["first_name"]as? String)!.hasPrefix("A")
                }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
            //print("sectionA: \(sectionA)")
            let sectionB = self.arrRes.filter(){
                return ($0["first_name"]as? String)!.hasPrefix("B")
                }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
            //print("sectionB: \(sectionB)")
            let sectionC = self.arrRes.filter(){
                return ($0["first_name"]as? String)!.hasPrefix("C")
                }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
            //print("sectionC: \(sectionC)")
            let sectionD = self.arrRes.filter(){
                return ($0["first_name"]as? String)!.hasPrefix("D")
                }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
            
            let sectionE = self.arrRes.filter(){
                return ($0["first_name"]as? String)!.hasPrefix("E")
                }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
            
            let sectionF = self.arrRes.filter(){
                return ($0["first_name"]as? String)!.hasPrefix("F")
                }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
            
            let sectionG = self.arrRes.filter(){
                return ($0["first_name"]as? String)!.hasPrefix("G")
                }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
            
            let sectionH = self.arrRes.filter(){
                return ($0["first_name"]as? String)!.hasPrefix("H")
                }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
            
            let sectionI = self.arrRes.filter(){
                return ($0["first_name"]as? String)!.hasPrefix("I")
                }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
            
            let sectionJ = self.arrRes.filter(){
                return ($0["first_name"]as? String)!.hasPrefix("J")
                }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
            
            let sectionK = self.arrRes.filter(){
                return ($0["first_name"]as? String)!.hasPrefix("K")
                }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
            
            let sectionL = self.arrRes.filter(){
                return ($0["first_name"]as? String)!.hasPrefix("L")
                }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
            
            let sectionM = self.arrRes.filter(){
                return ($0["first_name"]as? String)!.hasPrefix("M")
                }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
            
            let sectionN = self.arrRes.filter(){
                return ($0["first_name"]as? String)!.hasPrefix("N")
                }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
            
            let sectionO = self.arrRes.filter(){
                return ($0["first_name"]as? String)!.hasPrefix("O")
                }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
            
            let sectionP = self.arrRes.filter(){
                return ($0["first_name"]as? String)!.hasPrefix("P")
                }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
            
            let sectionQ = self.arrRes.filter(){
                return ($0["first_name"]as? String)!.hasPrefix("Q")
                }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
            
            let sectionR = self.arrRes.filter(){
                return ($0["first_name"]as? String)!.hasPrefix("R")
                }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
            
            let sectionS = self.arrRes.filter(){
                return ($0["first_name"]as? String)!.hasPrefix("S")
                }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
            
            let sectionT = self.arrRes.filter(){
                return ($0["first_name"]as? String)!.hasPrefix("T")
                }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
            
            let sectionU = self.arrRes.filter(){
                return ($0["first_name"]as? String)!.hasPrefix("U")
                }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
            
            let sectionV = self.arrRes.filter(){
                return ($0["first_name"]as? String)!.hasPrefix("V")
                }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
            
            let sectionW = self.arrRes.filter(){
                return ($0["first_name"]as? String)!.hasPrefix("W")
                }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
            
            let sectionX = self.arrRes.filter(){
                return ($0["first_name"]as? String)!.hasPrefix("X")
                }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
            
            let sectionY = self.arrRes.filter(){
                return ($0["first_name"]as? String)!.hasPrefix("Y")
                }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
            
            let sectionZ = self.arrRes.filter(){
                return ($0["first_name"]as? String)!.hasPrefix("Z")
                }.sorted(by: {($0["last_name"]as? String)! < ($1["last_name"]as? String)!})
            
            
            self.objectsArray = [Objects(sectionName:"A", sectionObjects:sectionA), Objects(sectionName:"B", sectionObjects:sectionB), Objects(sectionName:"C", sectionObjects:sectionC), Objects(sectionName:"D", sectionObjects:sectionD), Objects(sectionName:"E", sectionObjects:sectionE), Objects(sectionName:"F", sectionObjects:sectionF), Objects(sectionName:"G", sectionObjects:sectionG), Objects(sectionName:"H", sectionObjects:sectionH), Objects(sectionName:"I", sectionObjects:sectionI), Objects(sectionName:"J", sectionObjects:sectionJ), Objects(sectionName:"K", sectionObjects:sectionK), Objects(sectionName:"L", sectionObjects:sectionL), Objects(sectionName:"M", sectionObjects:sectionM), Objects(sectionName:"N", sectionObjects:sectionN), Objects(sectionName:"O", sectionObjects:sectionO), Objects(sectionName:"P", sectionObjects:sectionP), Objects(sectionName:"Q", sectionObjects:sectionQ), Objects(sectionName:"R", sectionObjects:sectionR), Objects(sectionName:"S", sectionObjects:sectionS), Objects(sectionName:"T", sectionObjects:sectionT), Objects(sectionName:"U", sectionObjects:sectionU), Objects(sectionName:"V", sectionObjects:sectionV), Objects(sectionName:"W", sectionObjects:sectionW), Objects(sectionName:"X", sectionObjects:sectionX), Objects(sectionName:"Y", sectionObjects:sectionY), Objects(sectionName:"Z", sectionObjects:sectionZ)]
            
            
            arrIndexSection = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
            
        }else{
            let filterState = fstates.sorted(by: {($0["first_name"]as? String)! < ($1["first_name"]as? String)!})
            
            self.objectsArray = [Objects(sectionName:String(selectedState.characters.prefix(1)), sectionObjects: filterState)]
            
            arrIndexSection = [String(selectedState.characters.prefix(1))]
            
        }
        
        
        
        self.tblJSON.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //tblState.isHidden = false //filter state Table
        picker.isHidden = true //pickeRView
        tblJSON.isHidden = false //legTable
    }
    
}

