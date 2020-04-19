import UIKit

class CountriesViewController: UIViewController {
  
  private var loadingView = LoadingView()
  private var noContentView = NoContentView()
  
  private let titleLabel: UILabel =  {
    let label = UILabel()
    label.text = "AirQuality"
    label.textAlignment = .center
    label.textColor = .systemBlue
    label.font = .systemFont(ofSize: 25, weight: .heavy)
    return label
  }()
  
  private lazy var collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    flowLayout.minimumLineSpacing =  ViewConstants.defaultMargin
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collectionView.contentInset = UIEdgeInsets(top: 0, left: ViewConstants.defaultMargin, bottom: 0, right: 0)
    collectionView.clipsToBounds = false
    collectionView.backgroundColor = .clear
    collectionView.decelerationRate = .fast
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.registerCell(ofType: CountryCollectionViewCell.self)

    return collectionView
  }()
  
  private var countryViewModels = [CountryViewModel]()
  private let facade: CountriesFacade
  private let navigator: CountriesNavigable
  
  init(facade: CountriesFacade, navigator: CountriesNavigable) {
    self.facade = facade
    self.navigator = navigator
    super.init(nibName: nil, bundle: nil)
    
    setupViews()
    setupHierarchy()
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadCities()
  }

  private func loadCities() {
    facade.getCountries(completion: { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success(let countryViewModels):
        self.update(with: countryViewModels)
      case .failure:
        self.noContentView.isHidden = false
      }
    })
  }
  
  private func update(with viewModels: [CountryViewModel]) {
    countryViewModels = viewModels
    collectionView.reloadData()
    loadingView.isHidden = true
    noContentView.isHidden = true
  }
  
  private func setupViews() {
    view.backgroundColor = .systemYellow

    loadingView.backgroundColor = .clear
  }
  
  private func setupHierarchy() {
    view.addSubviews(titleLabel, collectionView, loadingView, noContentView)
  }
  
  private func setupLayout() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      titleLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      titleLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
    ])
    
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionView.heightAnchor.constraint(equalToConstant: ViewConstants.collectionViewSizeHeight),
      collectionView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
      collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
    ])
    
    loadingView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      loadingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      loadingView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      loadingView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
    ])
    
    noContentView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      noContentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      noContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      noContentView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      noContentView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
    ])
  }
}

extension CountriesViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return countryViewModels.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueCell(ofType: CountryCollectionViewCell.self, indexPath: indexPath)
    cell.update(using: countryViewModels[indexPath.row])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    navigator.toMeasurement(countryCode: countryViewModels[indexPath.row].code)
  }
}

extension CountriesViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width - ViewConstants.collectionViewInset, height: collectionView.frame.height)
  }
}

extension CountriesViewController: UIScrollViewDelegate {
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    targetContentOffset.pointee = scrollView.contentOffset
    
    var factor: CGFloat = 0.5
    if velocity.x < 0 {
      factor = -factor
    }
    
    let indexPath = IndexPath(row: (Int(scrollView.contentOffset.x/(collectionView.frame.width - ViewConstants.collectionViewInset) + factor)), section: 0)
    collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
  }
}
