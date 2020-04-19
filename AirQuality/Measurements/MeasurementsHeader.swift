import UIKit

protocol MeasurementsHeaderDelegate: class {
  func didSelectParameter(_ parameter: String)
}

class MeasurementsHeader: UIView {
  
  private let countryLabel = UILabel()
  private let imageView = UILabel()
  private let parameterSelectionView = ParameterSelectionView()
  
  weak var delegate: MeasurementsHeaderDelegate?
  
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
    backgroundColor = .systemYellow
    layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
    layer.shadowRadius = 5
    layer.shadowOpacity = 0.2
    layer.shadowOffset = CGSize(width: 0, height: 8)
    clipsToBounds = false
    
    countryLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    countryLabel.textColor = .systemBlue
    countryLabel.textAlignment = .center
    
    parameterSelectionView.delegate = self
  }
  
  private func setupHierarchy() {
    addSubviews(countryLabel, parameterSelectionView)
  }
  
  private func setupLayout() {
    parameterSelectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          parameterSelectionView.heightAnchor.constraint(equalToConstant: ViewConstants.parametersSelectionViewHeight),
          parameterSelectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ViewConstants.defaultMargin),
          parameterSelectionView.leftAnchor.constraint(equalTo: leftAnchor),
          parameterSelectionView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    
    countryLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      countryLabel.bottomAnchor.constraint(equalTo: parameterSelectionView.topAnchor, constant: -ViewConstants.defaultMargin),
      countryLabel.leftAnchor.constraint(equalTo: leftAnchor),
      countryLabel.rightAnchor.constraint(equalTo: rightAnchor)
    ])
  }
  
  func update(with countryName: String) {
    countryLabel.text = countryName
  }
}

extension MeasurementsHeader: ParameterSelectionViewDelegate {
  func didSelectParameter(_ parameter: String) {
    delegate?.didSelectParameter(parameter)
  }
}
