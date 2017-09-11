//
//  DoctorsProvider.swift
//  DoctorsApp
//
//  Created by Peter Mosaad on 9/10/17.
//  Copyright © 2017 Peter Mosaad. All rights reserved.
//

import Foundation

protocol DoctorsProvider {
  func searchDoctors(with text: String, coordiantes: Coordinates, completion: @escaping (_ :[Doctor]?, _ :Error?) -> Void)
}

class DoctorsProviderImpl: DoctorsProvider {

  let authenticationProvider: AuthenticationProvider
  let doctorsService: DoctorsServiceClient

  init(authenticationProvider: AuthenticationProvider, doctorsService: DoctorsServiceClient) {
    self.authenticationProvider = authenticationProvider
    self.doctorsService = doctorsService
  }

  func searchDoctors(with text: String, coordiantes: Coordinates, completion: @escaping (_ :[Doctor]?, _ :Error?) -> Void) {

    guard let authToken = authenticationProvider.getAuthenticationToken()  else {
      completion(nil, nil)
      return
    }

    let params = SearchDoctorsParameters(searchQuery: text, authToken: authToken, coordinates: coordiantes)
    doctorsService.searchDoctros(with: params) { (docotsList, error) in
      guard let list = docotsList else {
        completion(nil, error)
        return
      }
      completion(list, nil)
    }
  }
}

