//
//  ListViewController.swift
//  Engineer_AI_Practical
//
//  Created by PCQ166 on 20/12/19.
//  Copyright © 2019 PCQ166. All rights reserved.
//

import UIKit
import UIScrollView_InfiniteScroll

final class ListViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: Variables
    private var viewModel = ListViewModel()
    private let count = 20
    
    private var activePostCounts : Int = 0 {
        didSet {
            self.title = "Number Of Selected Posts : \(activePostCounts)"
        }
    }
    
    lazy var refreshControl : UIRefreshControl = {
        let refreshcontrol = UIRefreshControl()
        refreshcontrol.addTarget(self, action: #selector(self.handlePullToRefresh), for: UIControl.Event.valueChanged)
        return refreshcontrol
    }()
    
    //MARK : -LIFECYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activePostCounts = 0
        tableView.addSubview(refreshControl)
        self.getLists()
    }
    
    //MARK: -HandlePullToRefresh
    @objc private func handlePullToRefresh() {
        self.viewModel.pageNumber = 0
        self.activePostCounts = 0
        self.getLists()
    }
    
    //MARK: -WEBSERVICE
    private func getLists() {
        self.viewModel.loading {
            if self.viewModel.pageNumber == 0 {
                self.showProgress()
            }
            else {
                self.tableView.beginInfiniteScroll(true)
            }
        }
        self.viewModel.catch { (error) in
            self.showAlertWithError(error: error)
        }
        self.viewModel.success {
            self.tableView.reloadData()
        }
        self.viewModel.finish {
            if self.viewModel.pageNumber == 0 {
                self.dismissProgress()
                self.refreshControl.endRefreshing()
            }
            else {
                self.tableView.finishInfiniteScroll()
            }
        }
        if NetworkManager.shared.reachabilityManager?.isReachable ?? false {
            self.viewModel.getListByDate(page: self.viewModel.pageNumber)
        }
        else {
            self.showAlertWithError(error: .noInternet)
        }
    }

}

//MARK : - UITableViewDelegate And DataSource
extension ListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.arrayOfLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCellFromNIB(ListTableViewCell.self)
        cell.delegate = self
        cell.list = self.viewModel.arrayOfLists[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if tableView.visibleCells.contains(cell) {
                self.viewModel.isMoreData = (self.viewModel.pageNumber < self.viewModel.numberOfPages ?? 0) ? true : false
                if indexPath.row == self.viewModel.arrayOfLists.count - 1 {
                    if self.viewModel.isDataLoading == false && self.viewModel.isMoreData == true {
                        self.viewModel.pageNumber += 1
                        self.getLists()
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let status = !self.viewModel.arrayOfLists[indexPath.row].status
        if let cell = tableView.cellForRow(at: indexPath) as? ListTableViewCell {
            self.didChangeStatus(status: status, cell: cell)
        }
    }
}

//MARK: - DELEGATE
extension ListViewController : ListTableViewCellDelegate {
    func didChangeStatus(status: Bool, cell: ListTableViewCell) {
        if let indexpath = tableView.indexPath(for: cell) {
            self.viewModel.arrayOfLists[indexpath.row].status = status
            if status {
                self.activePostCounts += 1
            } else {
                self.activePostCounts -= 1
            }
            self.tableView.reloadRows(at: [indexpath], with: .automatic)
        }
    }
    
}
