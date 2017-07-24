import UIKit
import XCTest
import NMKeychain

class Tests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testSetValue() {
    let dataInKeychain = NMKeychain<Date?>(
      key: "dataInKeychain_unique_key",
      identifier: "unique_keychain_identifier",
      label: "Label for this data",
      defaultValue: nil,
      synchronizable: true,
      accessibility: .afterFirstUnlock,
      onChange: nil
    )
    
    let now = Date()
    dataInKeychain.value = now
    XCTAssertEqual(dataInKeychain.value, now)
  }
  
}
