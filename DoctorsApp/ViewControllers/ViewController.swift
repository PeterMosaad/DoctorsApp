//
//  ViewController.swift
//  DoctorsApp
//
//  Created by Peter Mosaad on 9/8/17.
//  Copyright © 2017 Peter Mosaad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  private let authenticationProvider = DependeciesProvider.sharedInstance.authenticationProvider()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  func openSearchDoctorsScreen() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier :"SearchDoctorsNavigation") as! UINavigationController
    self.present(viewController, animated: true)
  }

  override func viewDidAppear(_ animated: Bool) {
    authenticationProvider.loadLastSavedAuthentication()
    guard let _ = authenticationProvider.getAuthenticationToken() else {
      requestAuthenticationToken()
      return
    }
    openSearchDoctorsScreen()
  }

  func requestAuthenticationToken() {

    showLoadingView()
    authenticationProvider.authenticate(with: "ioschallenge@uvita.eu", password: "shouldnotbetoohard") { [weak self] (authentication, error) in
      self?.hideLoadingView()
      guard let _ = authentication else {
        var errorMsg = "Can't authenticate User"
        if let msg = error?.localizedDescription {
          errorMsg = msg
        }
        self?.showError(message: errorMsg)
        return
      }
      self?.openSearchDoctorsScreen()
    }
  }
}

