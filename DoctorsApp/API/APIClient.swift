//
//  APIClient.swift
//  DoctorsApp
//
//  Created by Peter Mosaad on 9/10/17.
//  Copyright © 2017 Peter Mosaad. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

let baseServiceURL = "https://api.uvita.eu"
let imagesServiceURL = baseServiceURL + "/api/users/me/files/"

struct ServicePath {
  static let authentication = "/oauth/token"
  static let searchDoctors = "/api/users/me/doctors"
}

enum RequestHTTPMethod {
  case get
  case head
  case post
  case put
  case patch
  case delete
}

protocol RequestParameters {
  func queryRepresentation() -> [String: String]
  func httpHeaders() -> [String: String]
  func HTTPMethod() -> RequestHTTPMethod
  func requestURL() -> URL
}

extension RequestParameters {
  func defaulHeaders() -> [String : String] {
    return ["Accept" : "application/json"]
  }
  func baseURL() -> String {
    return baseServiceURL
  }
}

protocol HTTPProvider {
  func executeRequest(with parameters: RequestParameters, completion: @escaping (_ :Any?, _ :Error?) -> Void)
}

fileprivate var singleton: ApiClient?

/**
 Centralized RESTful instance to communicate with the API
 */
public class ApiClient {
  
  private let httpProvider: HTTPProvider

  init(httpProvider: HTTPProvider) {
    self.httpProvider = httpProvider
  }

  func executeRequest(with parameters: RequestParameters, completion: @escaping (_ :Any?, _ :Error?) -> Void) {
    httpProvider.executeRequest(with: parameters, completion: completion)
  }
}
