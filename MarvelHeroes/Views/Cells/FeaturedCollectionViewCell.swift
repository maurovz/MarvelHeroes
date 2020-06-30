import UIKit

class FeaturedCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var imageView: UIImageView!
  static let identifier = "FeaturedCollectionViewCell"

  override func awakeFromNib() {
    super.awakeFromNib()
    createBlurrView()
  }

  public func configure(imageUrl: String) {
    imageView.kf.indicatorType = .activity
    imageView.kf.setImage(with: URL(string: imageUrl))
  }

  private func createBlurrView() {

  }
}
