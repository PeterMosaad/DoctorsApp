//
//  AuthentcationAPIClient.swift
//  DoctorsApp
//
//  Created by Peter Mosaad on 9/10/17.
//  Copyright © 2017 Peter Mosaad. All rights reserved.
//

import Foundation
import Unbox

protocol AuthenticationServiceClient {
  func autenticate(with requestParams: AuthenticationRequestParameters,  completion: @escaping (_ :AuthenticationObject?, _ :Error?) -> Void)
}

extension ApiClient: AuthenticationServiceClient {
  func autenticate(with requestParams: AuthenticationRequestParameters,  completion: @escaping (_ :AuthenticationObject?, _ :Error?) -> Void) {
    executeRequest(with: requestParams) { (response, error) in
      guard let json = response as? [String: Any] else {
          completion(nil, error)
          return
      }
      var authObject: AuthenticationObject?

      let authObjectUnboxer = Unboxer(dictionary: json)
      do {
        authObject = try AuthenticationObject(unboxer: authObjectUnboxer)
      } catch {
        authObject = nil
      }
      completion(authObject, nil)
    }
  }
}

