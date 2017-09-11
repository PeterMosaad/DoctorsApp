//
//  RequestParameters.swift
//  DoctorsApp
//
//  Created by Peter Mosaad on 9/10/17.
//  Copyright © 2017 Peter Mosaad. All rights reserved.
//

import Foundation

fileprivate enum QueryKeys {
  static let grantType = "grant_type"
  static let username = "username"
  static let password = "password"
}

class AuthenticationRequestParameters : RequestParameters {

  let userName: String
  let password: String

  init(userName: String, password: String) {
    self.userName = userName
    self.password = password
  }

  func httpHeaders() -> [String : String] {
    var headers = defaulHeaders()
    headers["Authorization"] = "Basic aXBob25lOmlwaG9uZXdpbGxub3RiZXRoZXJlYW55bW9yZQ=="
    headers["Content-Type"] = "application/x-www-form-urlencoded"
    return headers
  }

  func HTTPMethod() -> RequestHTTPMethod {
    return .post
  }

  func requestURL() -> URL {
    return URL(string: baseURL() + ServicePath.authentication)!
  }

  func queryRepresentation() -> [String: String] {
    var queryParams = [String: String]()
    queryParams[QueryKeys.grantType] = "password"
    queryParams[QueryKeys.username] = userName
    queryParams[QueryKeys.password] = password
    return queryParams
  }
}


