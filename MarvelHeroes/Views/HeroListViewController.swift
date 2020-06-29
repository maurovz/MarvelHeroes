import UIKit
import Combine

class HeroListViewController: UIViewController {
  @IBOutlet weak var featuredHeroesCollectionView: UICollectionView!
  @IBOutlet weak var heroListCollectionView: UICollectionView!
  private let screenSize = UIScreen.main.bounds
  @IBOutlet weak var featuredPageControl: UIPageControl!
  let images = ["avatar", "comic"]

  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    addNavigationBarLogo(image: UIImage(named: "logo"))
    setPageControlNumberOfPages(pages: images.count)
  }

  override func viewDidAppear(_ animated: Bool) {
    setCurrentPageControlPage(page: 0)
  }

  private func setPageControlNumberOfPages(pages: Int) {
    featuredPageControl.numberOfPages = pages
  }

  private func setCurrentPageControlPage(page: Int) {
    featuredPageControl.currentPage = page
  }

  private func addNavigationBarLogo(image: UIImage?) {
    let imageView = UIImageView(image: image)
    imageView.contentMode = .scaleAspectFit
    self.navigationItem.titleView = imageView
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    guard previousTraitCollection != nil else { return }
    heroListCollectionView?.collectionViewLayout.invalidateLayout()
    featuredHeroesCollectionView?.collectionViewLayout.invalidateLayout()
  }
}

extension HeroListViewController: UICollectionViewDelegateFlowLayout {
  private func setupCollectionView() {
    setupLayouts()
    registerCollectionViewCellsNibs()
  }

  private func setupLayouts() {
    let layout = UICollectionViewFlowLayout()
    layout.minimumInteritemSpacing = 5
    layout.minimumLineSpacing = 10
    heroListCollectionView.collectionViewLayout = layout
    let featuredLayout = UICollectionViewFlowLayout()
    featuredLayout.minimumInteritemSpacing = 0
    featuredLayout.minimumLineSpacing = 0
    featuredLayout.scrollDirection = .horizontal
    featuredHeroesCollectionView.collectionViewLayout = featuredLayout
  }

  private func registerCollectionViewCellsNibs() {
    heroListCollectionView.register(
    UINib(nibName: HeroListCollectionViewCell.identifier, bundle: .main),
    forCellWithReuseIdentifier: HeroListCollectionViewCell.identifier)
    featuredHeroesCollectionView.register(
    UINib(nibName: FeaturedCollectionViewCell.identifier, bundle: .main),
    forCellWithReuseIdentifier: FeaturedCollectionViewCell.identifier)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    if collectionView == heroListCollectionView {
      return getHeroCellSize(collectionView: collectionView)
    } else {
      return getFeaturedCellSize(collectionView: collectionView)
    }
  }

  private func getHeroCellSize(collectionView: UICollectionView) -> CGSize {
    let numberOfColumns: CGFloat =  2
    let cellWidth = collectionView.frame.size.width
    let height = collectionView.frame.size.width / 2
    let xInset: CGFloat = 10
    let cellSpacing: CGFloat = 5
    return CGSize(width: (cellWidth / numberOfColumns) - (xInset + cellSpacing), height: height)
  }

  private func getFeaturedCellSize(collectionView: UICollectionView) -> CGSize {
    let cellWidth = collectionView.frame.size.width
    let height = collectionView.frame.size.height
    return CGSize(width: cellWidth, height: height)
  }
}

extension HeroListViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    if collectionView == featuredHeroesCollectionView {
      return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    } else {
      let sideMargins: CGFloat = 10
      return UIEdgeInsets(top: 0, left: sideMargins, bottom: 0, right: sideMargins)
    }
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == heroListCollectionView {
      return 10
    } else {
      return images.count
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if collectionView == featuredHeroesCollectionView {
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: FeaturedCollectionViewCell.identifier, for: indexPath) as? FeaturedCollectionViewCell
        else {
          fatalError("Error dequeuing Reusable Cell")
      }
      cell.configure(with: UIImage(named: images[indexPath.row]))
      return cell
    } else {
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: HeroListCollectionViewCell.identifier, for: indexPath) as? HeroListCollectionViewCell
        else {
          fatalError("Error dequeuing Reusable Cell")
      }
      cell.configure(with: UIImage(named: "hero"))
      return cell
    }
  }
}

extension HeroListViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView,
                      willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    setCurrentPageControlPage(page: indexPath.row)
  }
}
