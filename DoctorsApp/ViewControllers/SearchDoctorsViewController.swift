//
//  SearchDoctorsViewController.swift
//  DoctorsApp
//
//  Created by Peter Mosaad on 9/11/17.
//  Copyright © 2017 Peter Mosaad. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class SearchDoctorsViewController: UIViewController {

  @IBOutlet weak var searchTextField: UITextField!
  @IBOutlet weak var searchButton: UIButton!

  fileprivate lazy var presenter: SearchDoctorsPresenter = {
    let diProvider = DependeciesProvider.sharedInstance
    return SearchDoctorsPresenter(locationProvider: diProvider.locationProvider(),
                                  doctorsProvider: diProvider.doctorsProvider(),
                                  viewController: self)
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    searchButton.isEnabled = false

    presenter.notifyViewDidLoad()
  }

  @IBAction func searchButtonPressed(_ sender: Any) {
    guard let text = searchTextField.text else { return }
    presenter.searchButtonClicked(searchQuery: text)
  }
}

extension SearchDoctorsViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    guard let text = searchTextField.text else { return false}
    presenter.searchButtonClicked(searchQuery: text)
    return true
  }
}

extension SearchDoctorsViewController: SearchDoctorsScreen {

  func showLoadingView(with text: String?) {
    view.endEditing(true)
    let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
    loadingNotification.mode = MBProgressHUDMode.indeterminate
    var loadingText = "loading"
    if text != nil {
      loadingText = text!
    }
    loadingNotification.label.text = loadingText
  }

  func hideLoadingView() {
    MBProgressHUD.hide(for: view, animated: true)
  }

  func showError(message: String) {
    let alert = UIAlertController.init(title: nil, message: message, preferredStyle: UIAlertControllerStyle.alert)
    let action = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }

  func openDoctorsListScreen(doctorsList: [Doctor]) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    if let controller = storyboard.instantiateViewController(withIdentifier: "DoctorsListViewController") as? DoctorsListViewController {
      controller.updateWith(doctorsList: doctorsList)
      navigationController?.pushViewController(controller, animated: true)
    }
  }
}
