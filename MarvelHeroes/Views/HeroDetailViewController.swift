import UIKit

class HeroDetailViewController: UIViewController {
  @IBOutlet weak var heroCoverImageView: UIImageView!
  @IBOutlet weak var heroDescriptionTextView: UITextView!
  @IBOutlet weak var comicCountLabel: UILabel!
  @IBOutlet weak var seriesCountLabel: UILabel!
  var heroDetailsViewModel: HeroDetailsViewModel?

  override func viewDidLoad() {
    super.viewDidLoad()
    setupHeroInformation()
  }

  func setupHeroViewModel(heroDetailsViewModel: HeroDetailsViewModel) {
    self.heroDetailsViewModel = heroDetailsViewModel
  }

  func setupHeroInformation() {
    guard let heroDetailsViewModel = self.heroDetailsViewModel else { return }
    heroCoverImageView.kf.setImage(with: URL(string: heroDetailsViewModel.thumbnailImage))
    heroDescriptionTextView.text = heroDetailsViewModel.description
  }
}
