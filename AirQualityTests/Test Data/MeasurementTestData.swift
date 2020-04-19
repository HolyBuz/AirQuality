@testable import AirQuality

extension Measurement {

  static func testData(parameter: String = "03",
                       value: Float = 21.0,
                       unit: String = "µg/m3",
                       date: LocalDate = LocalDate(local: "2020-02-27T13:00:00+01:00"),
                       city: String = "London",
                       country: String = "UK") -> Measurement {
    
    return Measurement(parameter: parameter,
                       value: value,
                       unit: unit,
                       date: date,
                       city: city,
                       country: country)
  }
}
