import UIKit

protocol ParameterSelectionViewDelegate: class {
  func didSelectParameter(_ parameter: String)
}

final class ParameterSelectionView: UIView {
  private let no2Button = ParameterButton(title: "NO2")
  private let coButton = ParameterButton(title: "CO")
  private let so2Button = ParameterButton(title: "SO2")
  private let o3Button = ParameterButton(title: "03")
  private let pm25Button = ParameterButton(title: "PM25")
  private let parameterButtonsStackView = UIStackView()

  weak var delegate: ParameterSelectionViewDelegate?

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupViews()
    setupHierarchy()
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews() {
    
    parameterButtonsStackView.distribution = .fillEqually
    parameterButtonsStackView.spacing = ViewConstants.smallMargin
    
    [no2Button, coButton, so2Button, o3Button, pm25Button].forEach {
      $0.addTarget(self, action: #selector(didTapParameterButton(sender:)), for: .touchUpInside)
    }
  }
  
  private func setupHierarchy() {
    parameterButtonsStackView.addArrangedSubviews(no2Button,
                                                  coButton,
                                                  so2Button,
                                                  o3Button,
                                                  pm25Button)
    addSubview(parameterButtonsStackView)
  }
  
  private func setupLayout() {
    parameterButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      parameterButtonsStackView.topAnchor.constraint(equalTo: topAnchor),
      parameterButtonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
      parameterButtonsStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: ViewConstants.smallMargin),
      parameterButtonsStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -ViewConstants.smallMargin)
    ])
  }
  
  @objc private func didTapParameterButton(sender: UIButton) {
    guard let parameter = sender.titleLabel?.text else { return }
    
    sender.isSelected = !sender.isSelected
    
    delegate?.didSelectParameter(parameter.lowercased())
    
    parameterButtonsStackView.arrangedSubviews.forEach { button in
      if let button = button as? UIButton, button != sender {
        button.isSelected = false
      }
    }
  }
}

final class ParameterButton: UIButton {
  
  init(title: String) {
    super.init(frame: .zero)
    
    setTitle(title, for: .normal)

    layer.borderColor = UIColor.systemGreen.cgColor
    layer.cornerRadius = 10
    layer.borderWidth = 2
    setTitleColor(.systemGreen, for: .normal)
    setTitleColor(.systemGray6, for: .selected)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var isSelected: Bool {
    didSet {
      if isSelected {
        backgroundColor = .systemGreen
      } else {
        backgroundColor = .systemGray6
      }
    }
  }
}
