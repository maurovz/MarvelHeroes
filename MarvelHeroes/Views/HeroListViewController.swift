import UIKit
import Combine

class HeroListViewController: UIViewController {
  @IBOutlet weak var featuredHeroesCollectionView: UICollectionView!
  @IBOutlet weak var heroListCollectionView: UICollectionView!
  @IBOutlet weak var featuredPageControl: UIPageControl!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  private let heroListViewModel = HeroListViewModel()
  private var cancellables: Set<AnyCancellable> = []
  private var selectedHeroIndex = Int()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    addNavigationBarLogo(image: UIImage(named: Constants.logoImage))
    setupPageControl()
    bindViewModels()
  }

  override func viewDidAppear(_ animated: Bool) {
    setCurrentPageControlPage(page: 0)
  }

  private func bindViewModels() {
    showActivityIndicator()
    heroListViewModel.$heroes.sink { heroes in
      DispatchQueue.main.async {
        if heroes.count > 0 { self.hideActivityIndicator() }
        self.heroListCollectionView.reloadData()
      }
    }.store(in: &cancellables)
    heroListViewModel.$comics.sink { _ in
      DispatchQueue.main.async {
        self.featuredHeroesCollectionView.reloadData()
        self.setupPageControl()
      }
    }.store(in: &cancellables)
  }

  private func showActivityIndicator() {
    activityIndicator.isHidden = false
    activityIndicator.startAnimating()
  }

  private func hideActivityIndicator() {
    activityIndicator.isHidden = true
    activityIndicator.stopAnimating()
  }

  private func setupPageControl() {
    featuredPageControl.numberOfPages = heroListViewModel.comics.count
    setCurrentPageControlPage(page: heroListViewModel.comics.count)
  }

  private func setCurrentPageControlPage(page: Int) {
    featuredPageControl.currentPage = page
  }

  private func addNavigationBarLogo(image: UIImage?) {
    let imageView = UIImageView(image: image)
    imageView.contentMode = .scaleAspectFit
    self.navigationItem.titleView = imageView
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let heroDetailViewSegueIdentifier = "HeroDetailSegue"
    if segue.identifier == heroDetailViewSegueIdentifier {
      if let heroDetailViewController = segue.destination as? HeroDetailViewController {
        heroDetailViewController.setupHeroViewModel(heroDetailsViewModel: heroListViewModel.heroes[selectedHeroIndex])
      }
    }
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
      let sidesMargin: CGFloat = 0
      return UIEdgeInsets(top: sidesMargin, left: sidesMargin, bottom: sidesMargin, right: sidesMargin)
    } else {
      let sideMargins: CGFloat = 10
      return UIEdgeInsets(top: 0, left: sideMargins, bottom: 0, right: sideMargins)
    }
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == heroListCollectionView {
      return heroListViewModel.heroes.count
    } else {
      return heroListViewModel.comics.count
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if collectionView == featuredHeroesCollectionView {
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: FeaturedCollectionViewCell.identifier, for: indexPath) as? FeaturedCollectionViewCell
        else {
          fatalError(Constants.dequeErrorMessage)
      }
      let comics = heroListViewModel.comics
      cell.configure(imageUrl: comics[indexPath.row].thumbnailImage)
      return cell
    } else {
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: HeroListCollectionViewCell.identifier, for: indexPath) as? HeroListCollectionViewCell
        else {
          fatalError(Constants.dequeErrorMessage)
      }
      let hero = self.heroListViewModel.heroes[indexPath.row]
      cell.configure(imageUrl: hero.thumbnailImage, heroName: hero.name, modifiedDate: hero.modified)
      return cell
    }
  }
}

extension HeroListViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView,
                      willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    setCurrentPageControlPage(page: indexPath.row)
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedHeroIndex = indexPath.row
    let heroDetailViewSegueIdentifier = "HeroDetailSegue"
    performSegue(withIdentifier: heroDetailViewSegueIdentifier, sender: self)
  }
}
