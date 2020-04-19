final class CountryViewModel {
  
  let code: String
  let countryName: String?
  let count: Int
  
  private var flagEmojii: String {
    return code
        .unicodeScalars
        .map({ 127397 + $0.value })
        .compactMap(UnicodeScalar.init)
        .map(String.init)
        .joined()
  }
  
  var displayString: String {
    if let countryName = countryName {
      return flagEmojii + " " + countryName
    } else {
      return flagEmojii
    }
  }
  
  init(country: Country) {
    self.countryName = country.name
    self.code = country.code
    self.count = country.count
  }
}
