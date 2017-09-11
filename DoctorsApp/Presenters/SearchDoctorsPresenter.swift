//
//  SearchDoctorsPresenter.swift
//  DoctorsApp
//
//  Created by Peter Mosaad on 9/11/17.
//  Copyright © 2017 Peter Mosaad. All rights reserved.
//

import Foundation

protocol SearchDoctorsScreen: class {
  func showLoadingView(with text: String?)
  func hideLoadingView()
  func showError(message: String)
  func openDoctorsListScreen(doctorsList: [Doctor])
}

class SearchDoctorsPresenter {
  private let doctorsProvider: DoctorsProvider
  private let locationProvider: LocationProvider
  weak private var viewController: SearchDoctorsScreen?
  private var currentCoordinates: Coordinates?

  init(locationProvider: LocationProvider, doctorsProvider: DoctorsProvider, viewController: SearchDoctorsScreen) {
    self.doctorsProvider = doctorsProvider
    self.locationProvider = locationProvider
    self.viewController = viewController
  }

  func notifyViewDidLoad() {
    viewController?.showLoadingView(with: "Getting current location")
    locationProvider.getCurrentUserLocation { [weak self] (currentLocation, error) in
      DispatchQueue.main.async { [weak self] in
        self?.viewController?.hideLoadingView()
      }
      guard let  location = currentLocation else {
        DispatchQueue.main.async { [weak self] in
          self?.viewController?.showError(message: "Cant load user location")
        }
        return
      }
      self?.currentCoordinates = Coordinates(lat: location.coordinate.latitude, long: location.coordinate.longitude)
    }
  }

  func searchButtonClicked(searchQuery: String) {

    guard let coordinates = currentCoordinates else {
      viewController?.showError(message: "Cant search without")
      return
    }
    guard searchQuery.characters.count > 0 else {
      viewController?.showError(message: "Please enter search query")
      return
    }
    viewController?.showLoadingView(with: nil)

    doctorsProvider.searchDoctors(with: searchQuery, coordiantes: coordinates) { [weak self] (doctorsList, error) in
      guard let `self` = self else { return }
      DispatchQueue.main.async { [weak self] in
        self?.viewController?.hideLoadingView()
        if let results = doctorsList, results.count > 0 {
          self?.viewController?.openDoctorsListScreen(doctorsList: results)
        } else {
          var message = "No doctors found"
          if error != nil { message = error!.message() }
          self?.viewController?.showError(message: message)
        }
      }
    }
  }
}

fileprivate extension Error {
  func message() -> String {
    var errorMsg = "No doctors found"
    errorMsg = self.localizedDescription
    return errorMsg
  }
}

