//
//  DoctorsAPIClient.swift
//  DoctorsApp
//
//  Created by Peter Mosaad on 9/10/17.
//  Copyright © 2017 Peter Mosaad. All rights reserved.
//

import Foundation
import Unbox

protocol DoctorsServiceClient {
  func searchDoctros(with requestParams: SearchDoctorsParameters,  completion: @escaping (_ :[Doctor]?, _ :Error?) -> Void)
}

extension ApiClient: DoctorsServiceClient {
  func searchDoctros(with requestParams: SearchDoctorsParameters,  completion: @escaping (_ :[Doctor]?, _ :Error?) -> Void) {
    executeRequest(with: requestParams) { (response, error) in

      guard let value = response as? [String: Any],
        let doctorsJSON = value["doctors"] as? [[String: Any]] else {
          completion(nil, nil)
          return
      }
      let doctors = doctorsJSON.flatMap({ (docDict) -> Doctor? in
        let doctorsUnboxer = Unboxer(dictionary: docDict)
        do {
          return try Doctor(unboxer: doctorsUnboxer)
        } catch {
          return nil
        }
      })
      completion(doctors, nil)
    }
  }
}

