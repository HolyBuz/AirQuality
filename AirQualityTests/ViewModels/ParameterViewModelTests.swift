import XCTest
@testable import AirQuality

class ParameterViewModelTests: XCTestCase {
  
  var viewModel: ParameterViewModel!
  
  func testCreateViewModelCorrectly() {
    let parameter = Parameter.testData()
    viewModel = ParameterViewModel(parameter: parameter)
    
    XCTAssertTrue(viewModel.description == "Description")
    XCTAssertTrue(viewModel.name == "03")
  }
}
