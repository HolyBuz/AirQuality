final class ParameterViewModel {
  let name: String
  let description: String

  init(parameter: Parameter) {
    name = parameter.name
    description = parameter.description
  }
}
