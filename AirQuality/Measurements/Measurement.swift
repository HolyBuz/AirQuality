struct RootMeasurement: Decodable {
  let results: [Measurement]
}

struct Measurements: Decodable {
  let measurements: [Measurement]
}

struct LocalDate: Decodable {
  let local: String
}

struct Measurement: Decodable {
  let parameter: ParameterID
  let value: Float
  let unit: String
  let date: LocalDate
  let city: String
  let country: String
}
