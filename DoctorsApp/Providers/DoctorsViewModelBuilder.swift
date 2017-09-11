//
//  DoctorsViewModelBuilder.swift
//  DoctorsApp
//
//  Created by Peter Mosaad on 9/11/17.
//  Copyright © 2017 Peter Mosaad. All rights reserved.
//

import Foundation

protocol DoctorImageRequestBuilder {
  func request(with imageID: String) -> URLRequest?
}

struct DoctorViewModel {
  let name: String
  let address: String?
  let posterRequest: URLRequest?

  init(doctor: Doctor, posterRequestBuilder: DoctorImageRequestBuilder) {
    name = doctor.name
    address = doctor.address
    if let photoID = doctor.photoID {
      posterRequest = posterRequestBuilder.request(with: photoID)
    } else {
      posterRequest = nil
    }
  }
}

class DoctorImageRequestBuilderImpl: DoctorImageRequestBuilder {
  let baseImagesURL: String
  let authToken: String

  init(baseURL: String, authToken: String) {
    self.baseImagesURL = baseURL
    self.authToken = authToken
  }

  func request(with imageID: String) -> URLRequest? {
    let urlString = baseImagesURL + imageID
    guard let url = URL(string: urlString) else {
      return nil
    }
    var urlRequest = URLRequest(url: url)
    urlRequest.setValue("Bearer" + authToken, forHTTPHeaderField: "Authorization")
    return urlRequest
  }
}
