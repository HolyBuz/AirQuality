import Foundation

final class MeasurementViewModel {
  let parameter: String
  let city: String
  let value: String
  private let date: String
  private let countryCode: String
  
  var dateText: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let date = dateFormatter.date(from: self.date)
    return date?.toString() ?? ""
  }
  
  var countryName: String {
    let current = Locale(identifier: countryCode)
    return current.localizedString(forRegionCode: countryCode) ?? " "
  }
  
  init(measurement: Measurement) {
    self.parameter = measurement.parameter.uppercased()
    self.date = measurement.date.local
    self.city = measurement.city
    self.countryCode = measurement.country
    self.value = String(measurement.value) + " " + measurement.unit
  }
}
