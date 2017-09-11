//
//  Doctor.swift
//  DoctorsApp
//
//  Created by Peter Mosaad on 9/10/17.
//  Copyright © 2017 Peter Mosaad. All rights reserved.
//

import Foundation
import Unbox

class Doctor: Unboxable {
  let id: String
  let name: String
  let address: String?
  let photoID: String?

  required init(unboxer: Unboxer) throws {
    self.id = try unboxer.unbox(key: "id")
    self.name = try unboxer.unbox(key: "name")
    self.address = unboxer.unbox(key: "address")
    self.photoID = unboxer.unbox(key: "photoId")
  }
}

