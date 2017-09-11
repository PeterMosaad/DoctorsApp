//
//  LocationProvider.swift
//  DoctorsApp
//
//  Created by Peter Mosaad on 9/11/17.
//  Copyright © 2017 Peter Mosaad. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftLocation

protocol LocationProvider {
  func getCurrentUserLocation(completion: @escaping (_ :CLLocation?, _ :Error?) -> Void)
}

class LocationProviderImpl: LocationProvider {

  func getCurrentUserLocation(completion: @escaping (_ :CLLocation?, _ :Error?) -> Void) {
    Location.getLocation(accuracy: .city, frequency: .continuous, success: { (request, location) in
      request.cancel()
      completion(location, nil)
    }) { (request, last, error) in
      request.cancel()
      completion(last, error)
    }
  }
}

