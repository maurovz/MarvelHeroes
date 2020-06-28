import UIKit

class HeroListCollectionViewCell: UICollectionViewCell {
  @IBOutlet var imageView: UIImageView!
  static let identifier = "HeroListCollectionViewCell"
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  public func configure(with image: UIImage) {
    imageView.image = image
  }
  
  static func nib() -> UINib {
    return UINib(nibName: identifier, bundle: nil)
  }
}
