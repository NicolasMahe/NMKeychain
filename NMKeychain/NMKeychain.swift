//
//  Keychain.swift
//  EtherPortfolio
//
//  Created by Nicolas Mahé on 24/07/2017.
//  Copyright © 2017 Nicolas Mahé. All rights reserved.
//

import UIKit
import KeychainAccess

public class NMKeychain<T>: NSObject {
  
  public typealias ValueType = T
  
  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------
  
  private var key: String
  private var identifier: String
  private var label: String
  private var defaultValue: ValueType
  private var onChange: (() -> Void)?
  private var synchronizable: Bool
  private var accessibility: KeychainAccess.Accessibility
  
  //----------------------------------------------------------------------------
  // MARK: - Life cycle
  //----------------------------------------------------------------------------
  
  required public init(
    key: String,
    identifier: String,
    label: String,
    defaultValue: ValueType,
    synchronizable: Bool,
    accessibility: KeychainAccess.Accessibility,
    onChange: (() -> Void)? = nil
  ) {
    self.key = key
    self.identifier = identifier
    self.label = label
    self.defaultValue = defaultValue
    self.synchronizable = synchronizable
    self.accessibility = accessibility
    self.onChange = onChange
    
    super.init()
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Store
  //----------------------------------------------------------------------------
  
  private var store: Keychain {
    return Keychain(service: self.identifier)
      .label(self.label)
      .synchronizable(self.synchronizable)
      .accessibility(self.accessibility)
  }
  
  private func set(_ data: Data) {
    do {
      try self.store.set(data, key: self.key)
    }
    catch {
      print("cannot set to keychain: \(error)")
    }
  }
  
  private func getData() -> Data? {
    do {
      return try self.store.getData(self.key)
    }
    catch {
      print("cannot getData from keychain: \(error)")
    }
    return nil
  }
  
  public func remove() {
    do {
      try self.store.remove(self.key)
    }
    catch {
      print("cannot remove from keychain: \(error)")
    }
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Notification
  //----------------------------------------------------------------------------
  
  public var notification: Notification.Name {
    return Notification.Name(rawValue: self.key)
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Archive / unarchive
  //----------------------------------------------------------------------------
  
  private func archive(_ value: ValueType) -> Data {
    return NSKeyedArchiver.archivedData(withRootObject: value)
  }
  
  private func unarchive(data: Data) -> ValueType? {
    return NSKeyedUnarchiver.unarchiveObject(with: data) as? T
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Value
  //----------------------------------------------------------------------------
  
  public var value: ValueType {
    get {
      if let data = self.getData(),
        let value = self.unarchive(data: data) {
        return value
      }
      
      //get default asset
      return self.defaultValue
    }
    set(value) {
      let data = self.archive(value)
      self.set(data)
      
      //send notif
      NotificationCenter.default.post(
        name: self.notification,
        object: nil
      )
      
      self.onChange?()
    }
  }
  
}
