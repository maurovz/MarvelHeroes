import UIKit

class HeroListViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!
  private let reuseIdentifier = "HeroListCollectionViewCell"

  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

extension HeroListViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 150, height: 150)
  }
}

extension HeroListViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 2
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    return cell
  }
}

//extension HeroListViewController: UICollectionViewDelegate { }
