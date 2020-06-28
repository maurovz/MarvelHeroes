import UIKit

class HeroListViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!
  private let screenSize = UIScreen.main.bounds
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
  }
}

extension HeroListViewController: UICollectionViewDelegateFlowLayout {
  func setupCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 120, height: 120 )
    collectionView.collectionViewLayout = layout
    collectionView.register(UINib(nibName: HeroListCollectionViewCell.identifier, bundle: .main), forCellWithReuseIdentifier: HeroListCollectionViewCell.identifier)
    collectionView.delegate = self
    collectionView.dataSource = self
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 120, height: 120)
  }
}

extension HeroListViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroListCollectionViewCell.identifier, for: indexPath) as! HeroListCollectionViewCell
    cell.configure(with: UIImage(named: "hero")!)
    
    return cell
  }
}

extension HeroListViewController: UICollectionViewDelegate { }
