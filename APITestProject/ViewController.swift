//
//  ViewController.swift
//  APITestProject
//
//  Created by Macbook Pro on 24/12/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import MBProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var testTableVIew: UITableView!
    var apiDataArray:[APIData] = []
    var page :Int = 1
    var selectedCount:Int = 0
    var refreshContrroller:UIRefreshControl!
    
    var greyColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
    var isLoading : Bool = false
    var indicator: MBProgressHUD!
    
    var isFinalPage = false
    
    var bottomRefress:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testTableVIew.tableFooterView = UIView()

        indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        indicator.mode = .indeterminate
        indicator.label.text = "Loading"
        
        self.title = "Selected Hits 0"
        
        refreshContrroller = UIRefreshControl()
        refreshContrroller.attributedTitle = NSAttributedString(string: "Loading")
        refreshContrroller.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.testTableVIew.addSubview(self.refreshContrroller)
        
        getAPi(page: page)
        // Do any additional setup after loading the view, typically from a nib.
    }

    @objc func refresh()  {
    
            page += 1
            getAPi(page: page)
        
    }
    
    @objc func switchChanged(sender: UISwitch) {
        
        apiDataArray[sender.tag].isSelectedCell = !apiDataArray[sender.tag].isSelectedCell
        let cell = self.testTableVIew.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! TestProjectTableViewCell
        if apiDataArray[sender.tag].isSelectedCell {
            cell.toggleSwitch.isOn = true
            cell.backgroundColor = greyColor
            selectedCount += 1
        }
        else {
            cell.toggleSwitch.isOn = false
            cell.backgroundColor = .white
            selectedCount -= 1
        }
        self.title = "Selected Hits \(selectedCount)"
    }
    
    
    func getAPi(page: Int){
        APIManager.shared.callTestAPIsearchByDateWith(tag: "story", page: page) { (response, success, error) in
 
            self.indicator.hide(animated: true)
            
           
                if self.refreshContrroller.isRefreshing == true{
                    self.apiDataArray.removeAll()
                    self.selectedCount = 0
                    self.title = "Selected Hits 0"
                }
                
                self.refreshContrroller.endRefreshing()
                if success! && error == nil {
                    
                    self.apiDataArray.append(contentsOf: response!)
                    self.testTableVIew.reloadData()
                }
           
    
        }
    }
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testAppCell") as! TestProjectTableViewCell

        let object = apiDataArray[indexPath.row]
        cell.lblTitleText.text = object.strGetTitle
        let strDate = object.strGetCreatedAt
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let dateCreatedAt = dateFormatter.date(from: strDate) {
            
            dateFormatter.dateFormat = "dd, MMM yyyy hh:mm:ss a"
            cell.lblDateText.text = dateFormatter.string(from: dateCreatedAt)
        }
        
        if object.isSelectedCell {
            
            cell.toggleSwitch.isOn = true
            cell.backgroundColor = greyColor
            
        }
        else {
            cell.toggleSwitch.isOn = false
            cell.backgroundColor = .white
            
        }
        cell.toggleSwitch.tag = indexPath.row
        cell.toggleSwitch.addTarget(self, action: #selector(switchChanged(sender:)), for: .valueChanged)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        apiDataArray[indexPath.row].isSelectedCell = !apiDataArray[indexPath.row].isSelectedCell
        let cell = tableView.cellForRow(at: indexPath) as! TestProjectTableViewCell
        if apiDataArray[indexPath.row].isSelectedCell {
            cell.toggleSwitch.isOn = true
            cell.backgroundColor = greyColor
            selectedCount += 1
        }
        else {
            cell.toggleSwitch.isOn = false
            cell.backgroundColor = .white
            selectedCount -= 1
        }
        self.title = "Selected Hits \(selectedCount)"
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoading){
            //self.isLoading = true
            self.refresh()
        }
    }
    
}
