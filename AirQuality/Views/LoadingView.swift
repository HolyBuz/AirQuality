import UIKit

class LoadingView: UIView {
  
  private let activityIndicator = UIActivityIndicatorView(style: .large)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
    setupHierarchy()
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    backgroundColor = .systemGray6

    activityIndicator.color = .systemBlue
    activityIndicator.startAnimating()
  }
  
  private func setupHierarchy() {
    addSubview(activityIndicator)
  }
  
  private func setupLayout() {
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      activityIndicator.heightAnchor.constraint(equalToConstant: ViewConstants.collectionViewSizeHeight),
      activityIndicator.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
      activityIndicator.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
      activityIndicator.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor)
    ])
  }
  
  override var isHidden: Bool {
    didSet {
      DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }

        self.isHidden ? self.activityIndicator.stopAnimating() : self.activityIndicator.startAnimating()
      }
    }
  }
}
