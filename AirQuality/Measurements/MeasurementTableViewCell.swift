import UIKit

protocol MeasurementTableViewCellDelegate: class {
  func didTap(_ button: UIButton, with parameter: ParameterID)
}

class MeasurementTableViewCell: UITableViewCell {
  
  private let parameterLabel = UILabel()
  private let valueLabel = UILabel()
  private let dateLabel = UILabel()
  private let cityLabel = UILabel()
  private let infoButton = UIButton(type: .infoLight)
  private let mainHorizontalStackView = UIStackView()
  private let parameterInfoStackView = UIStackView()
  private let mainVerticalStackView = UIStackView()
  private let detailsStackView = UIStackView()
  
  private var measurementViewModel: MeasurementViewModel?
  weak var delegate: MeasurementTableViewCellDelegate?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupViews()
    setupHierarchy()
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews() {
    backgroundColor = .systemGray6

    infoButton.addTarget(self, action: #selector(didTapInfoButton(sender:)), for: .touchUpInside)

    mainVerticalStackView.axis = .vertical
    
    [mainVerticalStackView, parameterInfoStackView].forEach {
      $0.spacing = 20
    }
    
    [valueLabel, dateLabel].forEach {
      $0.textAlignment = .right
    }

    [dateLabel, cityLabel].forEach {
      $0.textColor = .lightGray
      $0.font = .systemFont(ofSize: 13)
    }
  }
  
  private func setupHierarchy() {
    contentView.addSubview(mainVerticalStackView)
    detailsStackView.addArrangedSubviews(cityLabel, dateLabel)
    parameterInfoStackView.addArrangedSubviews(valueLabel, infoButton)
    mainHorizontalStackView.addArrangedSubviews(parameterLabel, parameterInfoStackView)
    mainVerticalStackView.addArrangedSubviews(detailsStackView, mainHorizontalStackView)
  }
  
  private func setupLayout() {
    mainVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      mainVerticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewConstants.defaultMargin),
      mainVerticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ViewConstants.defaultMargin),
      mainVerticalStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: ViewConstants.defaultMargin),
      mainVerticalStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -ViewConstants.defaultMargin)
    ])
  }
  
  @objc private func didTapInfoButton(sender: UIButton) {
    guard let viewModel = measurementViewModel else { return }
    
    delegate?.didTap(sender, with: viewModel.parameter)
  }
  
  func update(with viewModel: MeasurementViewModel) {
    measurementViewModel = viewModel
    
    parameterLabel.text = viewModel.parameter
    valueLabel.text = viewModel.value
    dateLabel.text = viewModel.dateText
    cityLabel.text = viewModel.city
  }
  
  override func prepareForReuse() {
    [parameterLabel, valueLabel, dateLabel, cityLabel].forEach {
      $0.text = nil
    }
  }
}
