//
//  ViewController.swift
//  TaboolaTest_ios
//
//  Created by Yael Bilu Eran on 12/12/2018.
//  Copyright © 2018 yit. All rights reserved.
//

import UIKit
import TaboolaSDK

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var middleTaboolaViewHeight:CGFloat = UIScreen.main.bounds.height
    
    enum taboolaPlacement: String {
        case middle = "middleTaboolaView"
        case infinite = "infiniteTaboolaView"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        var nib = UINib(nibName: "TaboolaComponentCellView", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TaboolaComponentCellView")
        
        nib = UINib(nibName: "ComponentCellView", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ComponentCellView")

        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 2{
            if let taboolaCell = tableView.dequeueReusableCell(withIdentifier: "TaboolaComponentCellView") as? TaboolaComponentCellView{
                taboolaCell.taboolaView.delegate = self
                taboolaCell.taboolaView.ownerViewController = self
                taboolaCell.taboolaView.pageType = "article"
                taboolaCell.taboolaView.pageUrl = "https://www.ynet.co.il"
                taboolaCell.taboolaView.mode = "alternating-thumbnails-sdk"
                //taboolaCell.taboolaView.placement = "iOS Below Article Thumbnails"
                taboolaCell.taboolaView.placement = taboolaPlacement.middle.rawValue
                taboolaCell.taboolaView.targetType = "mix"
                taboolaCell.taboolaView.publisher = "ynet-ynet-app"
                taboolaCell.taboolaView.scrollEnable = false
                taboolaCell.taboolaView.autoResizeHeight = true
                taboolaCell.taboolaView.fetchContent()
                return taboolaCell
            }
            return UITableViewCell()
        }else if indexPath.row == 4{
            if let taboolaCell = tableView.dequeueReusableCell(withIdentifier: "TaboolaComponentCellView") as? TaboolaComponentCellView{
                taboolaCell.taboolaView.delegate = self
                taboolaCell.taboolaView.ownerViewController = self
                taboolaCell.taboolaView.pageType = "article"
                taboolaCell.taboolaView.pageUrl = "https://www.ynet.co.il"
                taboolaCell.taboolaView.mode = "thumbnails-a"
                taboolaCell.taboolaView.placement = taboolaPlacement.infinite.rawValue
                taboolaCell.taboolaView.targetType = "mix"
                taboolaCell.taboolaView.publisher = "ynet-ynet-app"
                taboolaCell.taboolaView.scrollEnable = true
                taboolaCell.taboolaView.autoResizeHeight = false
                taboolaCell.taboolaView.fetchContent()
                return taboolaCell
            }
            return UITableViewCell()
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComponentCellView") as? ComponentCellView
            cell?.myLbl.text = "\(indexPath.row)"
            return cell ?? UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2{
            return middleTaboolaViewHeight
        }
        return UIScreen.main.bounds.height
    }
    
    
}

extension ViewController : UITableViewDelegate{
    
}

extension ViewController: TaboolaViewDelegate {
    func onItemClick(_ placementName: String!, withItemId itemId: String!, withClickUrl clickUrl: String!, isOrganic organic: Bool) -> Bool {
        if organic {
            print("itemId: \(String(describing: itemId))")
        } else {
            print("clickUrl: \(String(describing: clickUrl))")
        }
        return true
    }
    
    func taboolaView(_ taboolaView: UIView!, didLoadPlacementNamed placementName: String!, withHeight height: CGFloat) {
        if taboolaPlacement.middle.rawValue == placementName{
            middleTaboolaViewHeight = height
        }
        print("Placement \(String(describing: placementName)) loaded successfully. height \(height)");
    }
    
    func taboolaView(_ taboolaView: UIView!, didFailToLoadPlacementNamed placementName: String!, withErrorMessage error: String!) {
        print("Placement \(String(describing: placementName)) failed to load because: %@ \(String(describing: error))");
    }
}




