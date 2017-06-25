//
//  FavoritePlacesVCViewController.swift
//  AStalker
//
//  Created by Bastian Morath on 04/02/15.
//  Copyright (c) 2015 Antum. All rights reserved.
//

import UIKit

class FavoritePlacesVC: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet var tableView:UITableView!
    
    //DataSource des TableViews
    var favoritePlacesDataSource: FavoritePlacesDataSource!
    
    var favoriteLocationsButton: LociButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritePlacesDataSource = FavoritePlacesDataSource(tableView: self.tableView, view: self.view)
        self.tableView.dataSource = favoritePlacesDataSource
        
        self.descriptionLabel.numberOfLines = 0
        
        self.favoriteLocationsButton = LociButton(type:.multipleLocations, color: .white)
        if let button = self.favoriteLocationsButton{
            button.addTarget(self, action: #selector(FavoritePlacesVC.favoriteLocationsButtonPressed), for:UIControlEvents.touchUpInside)
            self.view.addSubview(button)
            button.positionButtonToLocation(.topLeft)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.kCellHeight
    }
    
    
    //MARK:- Table View Delegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: Constants.headerHeight-40))
        headerView.backgroundColor = UIColor.clear
        
        let sharedLocationsLabel: UILabel = UILabel(frame: CGRect(x: 31, y: Constants.headerHeight - 30, width: 60, height: 15))
        sharedLocationsLabel.font = UIFont.ATFont()
        sharedLocationsLabel.text = "Locations"
        headerView.addSubview(sharedLocationsLabel)
        
        let timeLabel: UILabel = UILabel()
        timeLabel.font = UIFont.ATFont()
        timeLabel.text = "Time"
        headerView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //Add Constraints to timeLabel
        let views = ["timeLabel" : timeLabel]
        let metrics = ["marginRight":18, "marginTop" : Constants.headerHeight-27]
        let horizontalConstraintLikeView = "H:[timeLabel]-marginRight-|"
        let verticalConstraintLikeView = "V:|-marginTop-[timeLabel]"
        headerView.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: horizontalConstraintLikeView, options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metrics, views: views ) )
        headerView.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: verticalConstraintLikeView, options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metrics, views: views ) )
        
        self.tableView.tableHeaderView = headerView;
        return headerView
    }
    
    func favoriteLocationsButtonPressed(){
        self.dismissViewController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Save the changes
        LocationStore.defaultStore().coreDataPortal.save()
    }
    
}
