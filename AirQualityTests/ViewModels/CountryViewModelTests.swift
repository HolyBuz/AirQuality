import XCTest
@testable import AirQuality

class CountryViewModelTests: XCTestCase {
  
  var viewModel: CountryViewModel!
  
  func testCreateViewModelCorrectly() {
    let country = Country.testData()
    viewModel = CountryViewModel(country: country)
    
    XCTAssertTrue(viewModel.code == "IT")
    XCTAssertTrue(viewModel.displayString == "🇮🇹 Italia")
  }
}
