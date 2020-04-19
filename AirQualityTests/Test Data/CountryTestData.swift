@testable import AirQuality

extension Country {
  
  static func testData(countryCode: String = "IT", name: String = "Italia", count: Int = 300) -> Country {
    return Country(code: countryCode, name: name, count: count)
  }
}
