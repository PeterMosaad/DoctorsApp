//
//  AuthenticationProvider.swift
//  DoctorsApp
//
//  Created by Peter Mosaad on 9/10/17.
//  Copyright © 2017 Peter Mosaad. All rights reserved.
//

import Foundation
import Unbox

private let authCachingKey = "authCachingKey"

protocol AuthenticationProvider {
  func authenticate(with email: String, password: String, completion: @escaping (_ :AuthenticationObject?, _ :Error?) -> Void)
  func getAuthenticationToken() -> String?
  func loadLastSavedAuthentication()
}

class AuthenticationProviderImpl: AuthenticationProvider {
  private let authenticationService: AuthenticationServiceClient
  private let cachingProvider: CachingProvider
  private var currentAuthObject: AuthenticationObject?

  init(authenticationService: AuthenticationServiceClient, cachingProvider: CachingProvider) {
    self.authenticationService = authenticationService
    self.cachingProvider =  cachingProvider
  }

  func authenticate(with email: String, password: String, completion: @escaping (_ :AuthenticationObject?, _ :Error?) -> Void) {
    let params = AuthenticationRequestParameters(userName: email, password: password)
    authenticationService.autenticate(with: params) { [weak self] (authObject, error) in
      guard let authObject = authObject else {
        completion(nil, error)
        return 
      }
      self?.cachingProvider.cache(object: authObject.toDict(), forKey: authCachingKey)
      self?.currentAuthObject = authObject
      completion(authObject, nil)
    }
  }

  func getAuthenticationToken() -> String? {
    return currentAuthObject?.accessToken
  }

  func loadLastSavedAuthentication() {
    if let cachedObject = cachingProvider.load(objectForKey: authCachingKey) as? [String: Any] {
      let authObjectUnboxer = Unboxer(dictionary: cachedObject)
      do {
        let authObject = try AuthenticationObject(unboxer: authObjectUnboxer)
        if authObject.isValid() {
          currentAuthObject = authObject;
        }
      } catch {}
    }
  }
}

fileprivate extension AuthenticationObject {
  func isValid() -> Bool {
    let interval = Date().timeIntervalSince1970 + 120;
    return interval <= expiresIn
  }
}
