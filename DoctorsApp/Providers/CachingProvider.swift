//
//  CachingProvider.swift
//  DoctorsApp
//
//  Created by Peter Mosaad on 9/10/17.
//  Copyright © 2017 Peter Mosaad. All rights reserved.
//

import Foundation

/**
 Types implementing CachingProvder are responsible to cache and retrieve data
 */
public protocol CachingProvider {
  func cache(object: Any, forKey key: String)
  func load(objectForKey key: String) -> Any?
}

class CachingProviderImpl: CachingProvider {

  private func fullPersistencePath(file: String) -> URL {
    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
    let pathString = documentsPath.appendingPathComponent(file)
    return URL(fileURLWithPath: pathString)
  }

  func cache(object: Any, forKey key: String) {
    let archivedData = NSKeyedArchiver.archivedData(withRootObject: object)
    let url = fullPersistencePath(file: key)
    do {
      try archivedData.write(to: url)
    } catch {
      print(error)
    }
  }

  func load(objectForKey key: String) -> Any? {
    let url = fullPersistencePath(file: key)
    do {
      let data = try Data(contentsOf: url)
      return NSKeyedUnarchiver.unarchiveObject(with: data)
    } catch {
      print(error)
    }
    return nil
  }
}

