import UIKit

@IBDesignable final class CardContentView: UIView, NibLoadable {
    
    var viewModel: CardContentViewModel?
    @IBOutlet weak var secondaryLabel: UILabel!
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var imageToTopAnchor: NSLayoutConstraint!
    @IBOutlet weak var imageToLeadingAnchor: NSLayoutConstraint!
    @IBOutlet weak var imageToTrailingAnchor: NSLayoutConstraint!
    @IBOutlet weak var imageToBottomAnchor: NSLayoutConstraint!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fromNib()
        commonSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib()
        commonSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonSetup()
    }
    
    private func commonSetup() {
        // *Make the background image stays still at the center while we animationg,
        // else the image will get resized during animation.
    }
    
    // This "connects" highlighted (pressedDown) font's sizes with the destination card's font sizes
    func setFontState(isHighlighted: Bool) {
        if isHighlighted {
            primaryLabel.font = UIFont.systemFont(ofSize: 36 * GlobalConstants.cardHighlightedFactor, weight: .bold)
            secondaryLabel.font = UIFont.systemFont(ofSize: 18 * GlobalConstants.cardHighlightedFactor, weight: .semibold)
        } else {
            primaryLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
            secondaryLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        }
    }
}

struct CardContentViewModel {
    let primary: String
    let secondary: String
    let description: String
    let image: UIImage
    
    func highlightedImage() -> CardContentViewModel {
        let scaledImage = image.resize(toWidth: image.size.width * GlobalConstants.cardHighlightedFactor)
        return CardContentViewModel(primary: primary,
                                    secondary: secondary,
                                    description: description,
                                    image: scaledImage)
    }
}

extension UIImage {
    /// Resize UIImage to new width keeping the image's aspect ratio.
    func resize(toWidth scaledToWidth: CGFloat) -> UIImage {
        let image = self
        let oldWidth = image.size.width
        let scaleFactor = scaledToWidth / oldWidth
        
        let newHeight = image.size.height * scaleFactor
        let newWidth = oldWidth * scaleFactor
        
        let scaledSize = CGSize(width:newWidth, height:newHeight)
        UIGraphicsBeginImageContextWithOptions(scaledSize, true, image.scale)
        image.draw(in: CGRect(x: 0, y: 0, width: scaledSize.width, height: scaledSize.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage!
    }
}
