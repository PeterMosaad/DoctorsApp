//
//  HTTPProvider+Alamofire.swift
//  DoctorsApp
//
//  Created by Peter Mosaad on 9/10/17.
//  Copyright © 2017 Peter Mosaad. All rights reserved.
//

import Foundation
import Alamofire

fileprivate extension RequestHTTPMethod {
  func alamofireHTTPMethod() -> HTTPMethod {
    switch self {
    case .get:
      return HTTPMethod.get
    case .post:
      return HTTPMethod.post
    case .head:
      return HTTPMethod.head
    case .put:
      return HTTPMethod.put
    case .patch:
      return HTTPMethod.patch
    case .delete:
      return HTTPMethod.delete
    }
  }
}

class AlamofireProvider: HTTPProvider {
  func executeRequest(with parameters: RequestParameters, completion: @escaping (_ :Any?, _ :Error?) -> Void) {
    Alamofire.request(parameters.requestURL(),
                      method: parameters.HTTPMethod().alamofireHTTPMethod(),
                      parameters: parameters.queryRepresentation(),
                      headers: parameters.httpHeaders()
    ).validate()
      .responseJSON(completionHandler: { (response) -> Void in
        guard response.result.isSuccess else {
          completion(nil, response.result.error)
          return
        }
        completion(response.result.value, response.result.error)
      })
  }
}

