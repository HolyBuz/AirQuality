import UIKit

class ParameterDetailsViewController: UIViewController {
  private let noContentView = NoContentView(shouldHideImage: false)
  private let loadingView = LoadingView()
  
  private let parameterNameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15, weight: .heavy)
    label.textAlignment = .center
    return label
  }()
  
  private let paramenterDescriptionLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 12, weight: .medium)
    label.textAlignment = .center
    label.numberOfLines = 0
    return label
  }()
  
  private let facade: ParametersFacade
  private let parameterID: ParameterID
  
  init(facade: ParametersFacade, parameterID: ParameterID) {
    self.facade = facade
    self.parameterID = parameterID
    super.init(nibName: nil, bundle: nil)
    
    setupViews()
    setupHierarchy()
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews() {
    view.backgroundColor = .systemGray4
    
    noContentView.isHidden = true
  }
  
  private func setupHierarchy() {
    view.addSubviews(noContentView, loadingView, parameterNameLabel, paramenterDescriptionLabel)
  }
  
  private func setupLayout() {
    loadingView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      loadingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      loadingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      loadingView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      loadingView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
    ])
    
    noContentView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      noContentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      noContentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      noContentView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      noContentView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
    ])
    
    parameterNameLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      parameterNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ViewConstants.defaultMargin),
      parameterNameLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      parameterNameLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
    ])
    
    paramenterDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      paramenterDescriptionLabel.topAnchor.constraint(equalTo: parameterNameLabel.bottomAnchor),
      paramenterDescriptionLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      paramenterDescriptionLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      paramenterDescriptionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    getParameterDetails()
  }
  
  private func getParameterDetails() {
    facade.getParameterDetail(for: parameterID, completion: { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success(let parameterViewModel):
        if let parameterViewModel = parameterViewModel {
          self.parameterNameLabel.text = parameterViewModel.name
          self.paramenterDescriptionLabel.text = parameterViewModel.description
        } else {
          self.noContentView.isHidden = false
        }
        
      case .failure:
        self.noContentView.isHidden = false
        
      }
      
      self.loadingView.isHidden = true
    })
  }
}


