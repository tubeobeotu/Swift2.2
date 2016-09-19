//
//  MasterTableVC.swift
//  CustomizeTableViewCell
//
//  Created by hoangdangtrung on 1/7/16.
//  Copyright © 2016 hoangdangtrung. All rights reserved.
//

import UIKit

class MasterTableVC: UITableViewController {
    var arrayData: [DataItem]!
    var detailVC: DetailVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let item1: DataItem = DataItem.init(nameFC: "Manchester United", nameStd: "Old Trafford", imgLogo: "MU.png", imgStar: 5)
        let item2: DataItem = DataItem.init(nameFC: "Chelsea", nameStd: "Stamford Bridge", imgLogo: "Chelsea.png", imgStar: 4)
        let item3: DataItem = DataItem.init(nameFC: "Arsenal", nameStd: "Emirates", imgLogo: "Arsenal.png", imgStar: 4)
        let item4: DataItem = DataItem.init(nameFC: "Manchester City", nameStd: "Etihad", imgLogo: "MC.png", imgStar: 3)
        let item5: DataItem = DataItem.init(nameFC: "Liverpool", nameStd: "Anfield", imgLogo: "Liverpool.png", imgStar: 2)
        
        arrayData = [item1, item2, item3, item4, item5]
        
    }
    
    
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: CustomCellMaster! = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomCellMaster
        
        let item: DataItem = arrayData[indexPath.row]
        
        cell.labelFootballClub.text = item.nameFootballClub
        cell.labelStadium.text = item.nameStadium
        cell.imageViewLogo.image = item.imageLogo
        cell.imageViewStarRating.image = item.imageStarRating
        
        return cell
    }
    
    //MARK - Table View Delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if detailVC == nil {
            detailVC = self.storyboard?.instantiateViewControllerWithIdentifier("DetailVC") as! DetailVC
        }
        
        let item: DataItem = arrayData[indexPath.row]
        
        detailVC.stringTilte = item.nameStadium
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}











