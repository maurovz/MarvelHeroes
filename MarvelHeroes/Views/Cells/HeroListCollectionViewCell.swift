import UIKit
import Kingfisher

class HeroListCollectionViewCell: UICollectionViewCell {
  @IBOutlet var imageView: UIImageView!
  static let identifier = "HeroListCollectionViewCell"
  @IBOutlet var blurrView: UIVisualEffectView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var modificationDateLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    createBlurrView()
    roundCorners()
  }

  private func roundCorners() {
    self.layer.cornerRadius = 10
    self.layer.masksToBounds = true
  }

  private func createBlurrView() {
    let blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    blurredView.frame = self.blurrView.bounds
    blurredView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    blurrView.addSubview(blurredView)
    blurrView.sendSubviewToBack(blurredView)
  }

  public func configure(imageUrl: String, heroName: String, modifiedDate: String) {
    imageView.kf.indicatorType = .activity
    imageView.kf.setImage(with: URL(string: imageUrl))
    titleLabel.text = heroName
    modificationDateLabel.text = Constants.modifiedLabel + modifiedDate
  }
}
