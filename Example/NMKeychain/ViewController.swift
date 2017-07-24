//
//  ViewController.swift
//  NMKeychain
//
//  Created by nicolas@mahe.me on 07/24/2017.
//  Copyright (c) 2017 nicolas@mahe.me. All rights reserved.
//

import UIKit
import NMKeychain

class ViewController: UIViewController {
  
  @IBOutlet weak var label: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    self.example()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Example
  //----------------------------------------------------------------------------
  
  private let dataInKeychain = NMKeychain<Date?>(
    key: "dataInKeychain_unique_key",
    identifier: "unique_keychain_identifier",
    label: "Label for this data",
    defaultValue: Date(timeIntervalSinceNow: -600),
    synchronizable: true,
    accessibility: .afterFirstUnlock,
    onChange: {
      print("data has changed")
    }
  )
  
  func example() {
    print("should return the default value")
    print(self.dataInKeychain.value as Any)
    
    // set a value
    self.dataInKeychain.value = Date()
    print("should return the new value")
    print(self.dataInKeychain.value as Any)
  }
  
}

