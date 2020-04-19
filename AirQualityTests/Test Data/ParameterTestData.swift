@testable import AirQuality

extension Parameter {

  static func testData(name: String = "03",
                       description: String = "Description") -> Parameter {
    
    return Parameter(id: name.lowercased(),
                     name: name,
                     description: description)
  }
}
