//
//  DependeciesProvider.swift
//  DoctorsApp
//
//  Created by Peter Mosaad on 9/10/17.
//  Copyright © 2017 Peter Mosaad. All rights reserved.
//

import Foundation

class DependeciesProvider {

  static let sharedInstance = DependeciesProvider()
  private let apiClient: ApiClient
  fileprivate lazy var authProvider: AuthenticationProvider = {
    return AuthenticationProviderImpl(authenticationService: self.apiClient, cachingProvider: cachingProvider())
  }()

  init() {
    apiClient = ApiClient(httpProvider: AlamofireProvider())
  }

  func cachingProvider() -> CachingProvider {
    return CachingProviderImpl()
  }

  func authenticationProvider() -> AuthenticationProvider {
    return authProvider
  }

  func doctorsProvider() -> DoctorsProvider {
    return DoctorsProviderImpl(authenticationProvider: authenticationProvider(), doctorsService: apiClient)
  }

  func locationProvider() -> LocationProvider {
    return LocationProviderImpl()
  }

  func doctorImageRequestBuilder() -> DoctorImageRequestBuilder {
    return DoctorImageRequestBuilderImpl(baseURL: imagesServiceURL,
                                         authToken: authProvider.getAuthenticationToken()!)
  }
}
