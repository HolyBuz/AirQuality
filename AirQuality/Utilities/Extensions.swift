import UIKit

//MARK- CollectionView
extension UICollectionView {
  
  func registerCell<T: UICollectionViewCell>(ofType type: T.Type) {
    let cellName = String(describing: T.self)
    
    if Bundle.main.path(forResource: cellName, ofType: "nib") != nil {
      let nib = UINib(nibName: cellName, bundle: Bundle.main)
      
      register(nib, forCellWithReuseIdentifier: cellName)
    } else {
      register(T.self, forCellWithReuseIdentifier: cellName)
    }
  }
  
  func dequeueCell<T: UICollectionViewCell>(ofType type: T.Type, indexPath: IndexPath) -> T     {
    let cellName = String(describing: T.self)
    
    return dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as! T
  }
}

//MARK- TableView
extension UITableView {
  
  func registerCell<T: UITableViewCell>(ofType type: T.Type) {
    let cellName = String(describing: T.self)
    
    if Bundle.main.path(forResource: cellName, ofType: "nib") != nil {
      let nib = UINib(nibName: cellName, bundle: Bundle.main)
      
      register(nib, forCellReuseIdentifier: cellName)
    } else {
      register(T.self, forCellReuseIdentifier: cellName)
    }
  }
  
  func dequeueCell<T: UITableViewCell>(ofType type: T.Type) -> T     {
    let cellName = String(describing: T.self)
    
    return dequeueReusableCell(withIdentifier: cellName) as! T
  }
  
}

//MARK- Date
extension Date {
  func toString(format: String = "dd MMMM yyyy - HH:mm") -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.dateFormat = format
    
    return formatter.string(from: self)
  }
}

//MARK- StackView
extension UIStackView {
  func addArrangedSubviews(_ views: UIView...) {
    views.forEach {
      self.addArrangedSubview($0)
    }
  }
}

//MARK- View
extension UIView {
  func addSubviews(_ views: UIView...) {
    views.forEach {
      self.addSubview($0)
    }
  }
}
