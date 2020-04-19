struct RootParameter: Decodable {
  let results: [Parameter]
}

typealias ParameterID = String

struct Parameter: Decodable {
  let id: ParameterID
  let name: String
  let description: String
}
