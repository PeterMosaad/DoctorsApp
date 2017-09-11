//
//  DoctorsListViewController.swift
//  DoctorsApp
//
//  Created by Peter Mosaad on 9/11/17.
//  Copyright © 2017 Peter Mosaad. All rights reserved.
//

import Foundation
import UIKit

class DoctorsListViewController: UIViewController {

  @IBOutlet weak var doctorsTableView: UITableView!
  var doctorsViewModelList: [DoctorViewModel]?
  fileprivate lazy var presenter: DoctorsListPresenter = {
    let diProvider = DependeciesProvider.sharedInstance
    return DoctorsListPresenter(viewController: self,
                                imageRequestBuilder: diProvider.doctorImageRequestBuilder())
  }()

  private func prepareTableView() {

    doctorsTableView.rowHeight = UITableViewAutomaticDimension;
    doctorsTableView.estimatedRowHeight = 140.0;
    doctorsTableView.sectionHeaderHeight = UITableViewAutomaticDimension;
  }

  override func viewDidLoad() {
    prepareTableView()
  }

  func updateWith(doctorsList: [Doctor]) {
    _ = view // Force calling View to get tableView initialized
    presenter.gotDoctorsList(doctorsList)
  }
}

extension DoctorsListViewController: DoctorsListScreen {

  func updateDoctorsTable(doctorsList: [DoctorViewModel]) {
    doctorsViewModelList = doctorsList
    doctorsTableView.reloadData()
  }
}

extension DoctorsListViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let list = doctorsViewModelList else { return 0}
    return list.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell: UITableViewCell = UITableViewCell()
    if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: DoctorCell.cellIdentifier()) as? DoctorCell {
      if let viewModels = doctorsViewModelList, viewModels.count > indexPath.row {
        dequeuedCell.updateCell(doctorViewModel: viewModels[indexPath.row])
      }
      cell = dequeuedCell
    }
    return cell
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
}
