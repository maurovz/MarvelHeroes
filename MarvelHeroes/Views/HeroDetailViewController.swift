import UIKit

class HeroDetailViewController: UIViewController {
  @IBOutlet weak var heroCoverImageView: UIImageView!
  @IBOutlet weak var heroDescriptionTextView: UITextView!
  @IBOutlet weak var comicCountLabel: UILabel!
  @IBOutlet weak var seriesCountLabel: UILabel!
  @IBOutlet weak var eventsCountLabel: UILabel!
  @IBOutlet weak var storiesCountLabel: UILabel!

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
    setHeroStats()
  }

  func setHeroStats() {
    comicCountLabel.text = heroDetailsViewModel?.comics
    seriesCountLabel.text = heroDetailsViewModel?.series
    eventsCountLabel.text = heroDetailsViewModel?.events
    storiesCountLabel.text = heroDetailsViewModel?.stories
  }
}
