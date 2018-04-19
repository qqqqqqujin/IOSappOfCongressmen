//
//  LeftViewController.swift
//  csci571
//
//  Created by JIN QU on 24/11/2016.
//  Copyright © 2016 JIN QU. All rights reserved.
//

import UIKit
enum LeftMenu: Int {
    //case main = 0
    case legislators = 0
    case bills
    case committees
    case favorite
    case about
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class LeftViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, LeftMenuProtocol{

    @IBOutlet weak var leftTable: UITableView!
    @IBOutlet var logo: UIImageView!
    let menus = ["Legislators","Bills", "Committees", "Favorites", "About"]
        var legiViewController: UIViewController!
        var billViewController: UIViewController!
        var comViewController: UIViewController!
        var favViewController: UIViewController!
        var aboutViewController: UIViewController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage(named: "logo")
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 20, y: 20, width: 200, height: 65)
        logo.addSubview(imageView)
        
        leftTable.delegate = self
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let legiViewController = storyboard.instantiateViewController(withIdentifier: "legislators") as! legiTabBarController
        self.legiViewController = UINavigationController(rootViewController: legiViewController)
        
        let billViewController = storyboard.instantiateViewController(withIdentifier: "bills") as! billTabBarController
        self.billViewController = UINavigationController(rootViewController: billViewController)
        
        let comViewController = storyboard.instantiateViewController(withIdentifier: "committees") as! comTabBarController
        self.comViewController = UINavigationController(rootViewController: comViewController)
        
        let favViewController = storyboard.instantiateViewController(withIdentifier: "favorites") as! favTabBarController
        self.favViewController = UINavigationController(rootViewController: favViewController)
        
        let aboutViewController = storyboard.instantiateViewController(withIdentifier: "about") as! aboutViewController
        self.aboutViewController = UINavigationController(rootViewController: aboutViewController)
        
        self.navigationController?.isNavigationBarHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        func changeViewController(_ menu: LeftMenu) {
            switch menu {
    
            case .legislators:
                self.slideMenuController()?.changeMainViewController(self.legiViewController, close: true)
            case .bills:
                self.slideMenuController()?.changeMainViewController(self.billViewController, close: true)
            case .committees:
                self.slideMenuController()?.changeMainViewController(self.comViewController, close: true)
            case .favorite:
                self.slideMenuController()?.changeMainViewController(self.favViewController, close: true)
            case .about:
                self.slideMenuController()?.changeMainViewController(self.aboutViewController, close: true)
    
                
            }
    
        }
    
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "leftCell")!
//        
//        cell.textLabel?.text = menu[indexPath.row]
//        return cell
//    }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
            if let menu = LeftMenu(rawValue: indexPath.row) {
                switch menu {
                case .legislators, .bills, .committees, .favorite, .about:
                    let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "leftCell")!
    
                    cell.textLabel?.text = menus[indexPath.row]
                    return cell
                }
            }
            return UITableViewCell()
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.leftTable == scrollView {
            
        }
    }

}


