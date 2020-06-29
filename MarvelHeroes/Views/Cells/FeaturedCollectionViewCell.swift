import UIKit

class FeaturedCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var imageView: UIImageView!
  static let identifier = "FeaturedCollectionViewCell"

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  public func configure(with image: UIImage?) {
    imageView.image = image
  }
}
