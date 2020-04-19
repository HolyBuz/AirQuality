import UIKit

class NoContentView: UIView {
  
  private var boxImageView = UIImageView(image: #imageLiteral(resourceName: "emptyBox"))
  private var mainVerticalStackView = UIStackView()
  
  private var textLabel: UILabel = {
    let label = UILabel()
    label.text = NSLocalizedString("Sorry, no data from this country at the moment!", comment: "")
    label.font = .systemFont(ofSize: 20, weight: .medium)
    label.textAlignment = .center
    label.numberOfLines = 0
    return label
  }()
  
  init(shouldHideImage: Bool = false) {
    super.init(frame: .zero)
    
    setupViews()
    setupHierarchy()
    setupLayout()

    boxImageView.isHidden = shouldHideImage
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews() {
    backgroundColor = .systemGray6
    layer.cornerRadius = 20
    isHidden = true

    mainVerticalStackView.axis = .vertical
    mainVerticalStackView.spacing = 20
    
    boxImageView.contentMode = .scaleAspectFit
  }
  
  private func setupHierarchy() {
    addSubview(mainVerticalStackView)
    mainVerticalStackView.addArrangedSubviews(textLabel, boxImageView)
  }
  
  private func setupLayout() {
    mainVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      mainVerticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: ViewConstants.defaultMargin),
      mainVerticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ViewConstants.defaultMargin),
      mainVerticalStackView.leftAnchor.constraint(equalTo: leftAnchor),
      mainVerticalStackView.rightAnchor.constraint(equalTo: rightAnchor)
    ])
  }
}
