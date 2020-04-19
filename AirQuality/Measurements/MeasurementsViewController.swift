import UIKit

class MeasurementsViewController: UIViewController {
  
  private var noContentView = NoContentView()
  private var loadingView = LoadingView()
  private var measurementsHeader = MeasurementsHeader()
  private lazy var tableView: UITableView = {
    var tableView = UITableView()
    tableView.separatorInset = UIEdgeInsets(top: 0, left: ViewConstants.defaultMargin, bottom: 0, right: 0)
    tableView.allowsSelection = false
    tableView.bounces = false
    tableView.backgroundColor = .systemGray6
    tableView.tableFooterView = UIView()
    tableView.dataSource = self
    tableView.registerCell(ofType: MeasurementTableViewCell.self)
    return tableView
  }()
  
  private var measurementViewModels = [MeasurementViewModel]()
  private let facade: MeasurementsFacade
  private let navigator: MeasurementsNavigable
  private let countryCode: CountryCode
  
  init(facade: MeasurementsFacade, navigator: MeasurementsNavigable, countryCode: CountryCode) {
    self.facade = facade
    self.navigator = navigator
    self.countryCode = countryCode
    super.init(nibName: nil, bundle: nil)
    
    setupViews()
    setupHierarchy()
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews() {
    view.backgroundColor = .systemGray6
    
    measurementsHeader.delegate = self
  }
  
  private func setupHierarchy() {
    view.addSubviews(tableView, measurementsHeader, loadingView, noContentView)
  }
  
  private func setupLayout() {
    measurementsHeader.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      measurementsHeader.heightAnchor.constraint(equalToConstant:  ViewConstants.measurementsHeaderHeight),
      measurementsHeader.topAnchor.constraint(equalTo: view.topAnchor),
      measurementsHeader.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      measurementsHeader.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
    ])
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: measurementsHeader.bottomAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
    ])
    
    loadingView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      loadingView.topAnchor.constraint(equalTo: measurementsHeader.bottomAnchor),
      loadingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      loadingView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      loadingView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
    ])
    
    noContentView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      noContentView.topAnchor.constraint(equalTo: measurementsHeader.bottomAnchor, constant: ViewConstants.smallMargin),
      noContentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      noContentView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: ViewConstants.smallMargin),
      noContentView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -ViewConstants.smallMargin)
    ])
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    getMeasurements()
  }
  
  private func getMeasurements() {
    loadingView.isHidden = false
    
    facade.getAllMeasurements(for: countryCode, completion: { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success(let measurementViewModels):
         self.update(with: measurementViewModels)
      case .failure:
        self.noContentView.isHidden = false
      }
    })
  }
  
  private func update(with viewModels: [MeasurementViewModel]) {
    measurementViewModels = viewModels
    
    noContentView.isHidden = !viewModels.isEmpty
    loadingView.isHidden = true
    
    tableView.reloadData()
    
    if let countryName = viewModels.first?.countryName  {
      measurementsHeader.update(with: countryName)
    }
  }
}

extension MeasurementsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return measurementViewModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let viewModel = measurementViewModels[indexPath.row]
    let cell = tableView.dequeueCell(ofType: MeasurementTableViewCell.self)
    cell.delegate = self
    cell.update(with: viewModel)
    return cell
  }
}

extension MeasurementsViewController: MeasurementTableViewCellDelegate {
  func didTap(_ button: UIButton, with parameter: ParameterID) {
    navigator.toParameterDetails(from: button, with: parameter)
  }
}

extension MeasurementsViewController: MeasurementsHeaderDelegate {
  func didSelectParameter(_ parameter: String) {
    loadingView.isHidden = false

    facade.getMeasurements(for: parameter, with: countryCode, completion: { [weak self] result in
      guard let self = self else { return }

      switch result {
      case .success(let measurementViewModels):
         self.update(with: measurementViewModels)
      case .failure:
        self.noContentView.isHidden = false
      }
    })
  }
}
