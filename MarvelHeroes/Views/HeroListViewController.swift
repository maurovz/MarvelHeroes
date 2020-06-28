import UIKit

class HeroListViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

extension HeroListViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroListCollectionViewCell", for: indexPath)
    return cell
  }
}

extension HeroListViewController: UICollectionViewDelegate { }
