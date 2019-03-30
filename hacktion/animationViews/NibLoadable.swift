
import UIKit

protocol NibLoadable where Self: UIView {
    
    /// Setup this view with nib:
    /// 1. Load content view from nib (with the class name)
    /// 2. Set owner to self
    /// 3. Add it as a subview and fill edges with AutoLayout
    func fromNib() -> UIView?
}

extension NibLoadable {
    @discardableResult
    func fromNib() -> UIView? {
        let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as! UIView
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.edges(to: self)
        return contentView
    }
}

extension UIView {
    /// Constrain 4 edges of `self` to specified `view`.
    func edges(to view: UIView, top: CGFloat=0, left: CGFloat=0, bottom: CGFloat=0, right: CGFloat=0) {
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: left),
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: right),
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: top),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom)
            ])
    }
}
