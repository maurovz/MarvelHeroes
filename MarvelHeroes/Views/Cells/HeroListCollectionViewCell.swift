import UIKit
import Kingfisher

class HeroListCollectionViewCell: UICollectionViewCell {
  @IBOutlet var imageView: UIImageView!
  static let identifier = "HeroListCollectionViewCell"
  @IBOutlet var blurrView: UIVisualEffectView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var creationDateLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    createBlurrView()
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

  public func configure(imageUrl: String, heroName: String) {
    imageView.kf.setImage(with: URL(string: imageUrl))
    titleLabel.text = heroName
  }
}
