struct RootCountry: Decodable {
  let results: [Country]
}

typealias CountryCode = String

struct Country: Decodable {
  let code: CountryCode
  let name: String?
  let count: Int
}

