import UIKit

class HeroListCollectionViewCell: UICollectionViewCell {
  @IBOutlet var imageView: UIImageView!
  static let identifier = "HeroListCollectionViewCell"
  @IBOutlet var blurrView: UIVisualEffectView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var creationDateLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    createBlurrView()
    createHeroTittle()
  }
  
  private func createBlurrView() {
    let blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    blurredView.frame = self.blurrView.bounds
    blurredView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    blurrView.addSubview(blurredView)
    blurrView.sendSubviewToBack(blurredView)
  }
  
  func createHeroTittle() {
    
  }
  
  
  public func configure(with image: UIImage) {
    imageView.image = image
  }
}