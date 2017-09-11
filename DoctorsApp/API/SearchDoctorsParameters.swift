//
//  SearchDoctorsParameters.swift
//  DoctorsApp
//
//  Created by Peter Mosaad on 9/10/17.
//  Copyright © 2017 Peter Mosaad. All rights reserved.
//

import Foundation

fileprivate enum QueryKeys {
  static let search = "search"
  static let lat = "lat"
  static let lng = "lng"
}

struct Coordinates {
  let lat: Double
  let long: Double
}

class SearchDoctorsParameters : RequestParameters {

  let searchQuery: String
  let authToken: String
  let coordinates: Coordinates

  init(searchQuery: String, authToken: String, coordinates: Coordinates) {
    self.searchQuery = searchQuery
    self.authToken = authToken
    self.coordinates = coordinates
  }

  func httpHeaders() -> [String : String] {
    var headers = defaulHeaders()
    headers["Authorization"] = "Bearer" + authToken
    return headers
  }

  func HTTPMethod() -> RequestHTTPMethod {
    return .get
  }

  func requestURL() -> URL {
    return URL(string: baseURL() + ServicePath.searchDoctors)!
  }

  func queryRepresentation() -> [String: String] {
    var queryParams = [String: String]()
    queryParams[QueryKeys.search] = searchQuery
    queryParams[QueryKeys.lat] = String(coordinates.lat)
    queryParams[QueryKeys.lng] = String(coordinates.long)
    return queryParams
  }
}

