import UIKit

class HeroListViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!
  private let screenSize = UIScreen.main.bounds

  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    guard previousTraitCollection != nil else { return }
    collectionView?.collectionViewLayout.invalidateLayout()
  }
}

extension HeroListViewController: UICollectionViewDelegateFlowLayout {
  func setupCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.minimumInteritemSpacing = 5
    layout.minimumLineSpacing = 10
    collectionView.collectionViewLayout = layout
    collectionView.register(UINib(nibName: HeroListCollectionViewCell.identifier,
                                  bundle: .main), forCellWithReuseIdentifier: HeroListCollectionViewCell.identifier)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let numberOfColumns: CGFloat =  2
    let cellWidth = collectionView.frame.size.width
    let height = collectionView.frame.size.width / 2
    let xInset: CGFloat = 10
    let cellSpacing: CGFloat = 5
    return CGSize(width: (cellWidth / numberOfColumns) - (xInset + cellSpacing), height: height)
  }
}

extension HeroListViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    let sideMargins: CGFloat = 10
     return UIEdgeInsets(top: 0, left: sideMargins, bottom: 0, right: sideMargins)
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: HeroListCollectionViewCell.identifier, for: indexPath) as? HeroListCollectionViewCell
      else {
        fatalError("Error dequeue Reusable Cell")
    }
    cell.configure(with: UIImage(named: "hero")!)
    return cell
  }
}
