import XCTest
@testable import AirQuality

class MeasurementViewModelTests: XCTestCase {
  
  var viewModel: MeasurementViewModel!
  
  func testCreateViewModelCorrectly() {
    let measurement = Measurement.testData()
    viewModel = MeasurementViewModel(measurement: measurement)
    
    XCTAssertTrue(viewModel.value == "21.0 µg/m3")
    XCTAssertTrue(viewModel.dateText == "27 February 2020 - 12:00")
    XCTAssertTrue(viewModel.city == "London")
  }
}
