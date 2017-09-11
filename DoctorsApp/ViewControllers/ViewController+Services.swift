//
//  ViewController+Services.swift
//  DoctorsApp
//
//  Created by Peter Mosaad on 9/10/17.
//  Copyright © 2017 Peter Mosaad. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension ViewController {

  func showError(message: String) {
    let alert = UIAlertController.init(title: nil, message: message, preferredStyle: UIAlertControllerStyle.alert)
    let action = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }

  func showLoadingView() {
    view.endEditing(true)
    let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
    loadingNotification.mode = MBProgressHUDMode.indeterminate
    loadingNotification.label.text = "Loading"
  }

  func hideLoadingView() {
    MBProgressHUD.hide(for: view, animated: true)
  }
}

