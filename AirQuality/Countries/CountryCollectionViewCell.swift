import UIKit

final class CountryCollectionViewCell: UICollectionViewCell {
  
  private lazy var countryNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 20)
    label.textAlignment = .center
    label.textColor = .systemGray
    return label
  }()
  
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
    contentView.backgroundColor = .systemGray6
    contentView.layer.cornerRadius = 5
    
    layer.cornerRadius = 15.0
    layer.borderWidth = 0.0
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 2)
    layer.shadowRadius = 5.0
    layer.shadowOpacity = 0.3
    layer.masksToBounds = false
  }
  
  private func setupHierarchy() {
    contentView.addSubview(countryNameLabel)
  }
  
  private func setupLayout() {
    countryNameLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      countryNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
      countryNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      countryNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      countryNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor)
    ])
  }
  
  func update(using viewModel: CountryViewModel) {
    countryNameLabel.text = viewModel.displayString
  }
  
  override func prepareForReuse() {
    countryNameLabel.text = nil
  }
}

