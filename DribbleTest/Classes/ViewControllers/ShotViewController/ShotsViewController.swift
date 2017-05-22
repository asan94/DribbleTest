//
//  ShotsViewController.swift
//  DribbleTest
//
//  Created by Аметов Асан on 19.05.17.
//  Copyright © 2017 Asan Ametov. All rights reserved.
//

import UIKit
import MBProgressHUD
class ShotsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var viewModel: ShotsViewControllerVM!
    var refreshControl: UIRefreshControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerCellNib(ShotsCell.self)
        let offset: CGFloat = 20
        self.tableView.rowHeight = UIScreen.main.bounds.height / 2 - offset
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        self.showHUD()
        self.viewModel = ShotsViewControllerVM()
        self.tableView.addSubview(refreshControl)
        self.viewModel.getShotss()
        self.refreshControl.beginRefreshing()
        let nc = NotificationCenter.default
        nc.addObserver(forName:Notification.Name(rawValue:Constants.getShotsSuccess),
                       object:nil, queue:nil,
                       using:getShotsSuccess)
        nc.addObserver(forName:Notification.Name(rawValue:Constants.getShotsFailure),
                       object:nil, queue:nil,
                       using:getShotsFailure)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    func refresh(sender:AnyObject) {
        refreshBegin(newtext: "Refresh",
                     refreshEnd: {(x:Int) -> () in
        })
    }
    
    func refreshBegin(newtext:String, refreshEnd:@escaping (Int) -> ()) {
        DispatchQueue.main.async {
            self.viewModel.getShotss()
        }
    }
    
    //Server notification
    func getShotsSuccess(notification:Notification) -> Void {
        self.dismissHUD()
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
        }
        self.tableView.reloadData()
    }
    func getShotsFailure(notification:Notification) -> Void {
        self.dismissHUD()
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
        }
        tableView.reloadData()
        let error = notification.object
        self.showWithError(error: error as! NSError)
    }
    //Mark - UITableViewDataSource, UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getShotsCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String.className(ShotsCell.self)) as! ShotsCell
        let shot = viewModel.getShotForIndex(index: indexPath.row)
        cell.setupWithShot(shot: shot)
        return cell
    }
    
    
}

