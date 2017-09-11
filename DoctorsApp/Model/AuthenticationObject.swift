//
//  AuthenticationObject.swift
//  DoctorsApp
//
//  Created by Peter Mosaad on 9/10/17.
//  Copyright © 2017 Peter Mosaad. All rights reserved.
//

import Foundation
import Unbox

class AuthenticationObject: Unboxable {
  let accessToken: String
  let refreshToken: String
  let expiresIn: TimeInterval

  required init(unboxer: Unboxer) throws {
    self.accessToken = try unboxer.unbox(key: "access_token")
    self.refreshToken = try unboxer.unbox(key: "refresh_token")
    self.expiresIn = try unboxer.unbox(key: "expires_in")
  }

  func toDict() -> [String: Any] {
    var dict = [String: Any]()
    dict["access_token"] = accessToken
    dict["refresh_token"] = refreshToken
    dict["expires_in"] = expiresIn + Date().timeIntervalSince1970
    return dict
  }
}
