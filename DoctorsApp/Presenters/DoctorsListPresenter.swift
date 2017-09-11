//
//  DoctorsListPresenter.swift
//  DoctorsApp
//
//  Created by Peter Mosaad on 9/11/17.
//  Copyright © 2017 Peter Mosaad. All rights reserved.
//

import Foundation

protocol DoctorsListScreen: class {
  func updateDoctorsTable(doctorsList: [DoctorViewModel])
}

class DoctorsListPresenter {
  private let imageRequestBuilder: DoctorImageRequestBuilder
  weak private var viewController: DoctorsListScreen?

  init(viewController: DoctorsListScreen, imageRequestBuilder: DoctorImageRequestBuilder) {
    self.viewController = viewController
    self.imageRequestBuilder = imageRequestBuilder
  }

  private func viewModels(from doctorsList: [Doctor]) -> [DoctorViewModel] {
    var viewModels = [DoctorViewModel]()
    for doctor in doctorsList {
      viewModels.append(DoctorViewModel(doctor: doctor, posterRequestBuilder: imageRequestBuilder))
    }
    return viewModels
  }

  func gotDoctorsList(_ doctorsList: [Doctor]) {

    let viewModels = self.viewModels(from: doctorsList)
    viewController?.updateDoctorsTable(doctorsList: viewModels)
  }
}

