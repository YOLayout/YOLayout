//
//  CircleLayoutView.swift
//  YOLayoutExample
//
//  Created by John Boiles on 1/9/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

//! A view lays out its subviews in a circle.. in Swift!
@IBDesignable
class CircleLayoutView: YOView {
    var imageViews : [UIView] = []

    // Some magic to be able to tweak this value from inteface builder for visual testing
    @IBInspectable var imageViewCount : NSInteger = 8 {
    didSet {
        while self.imageViews.count < imageViewCount {
            self.addImageView(animated: false)
        }
        while self.imageViews.count > imageViewCount {
            self.removeImageView(animated: false)
        }
    }
}
    override func viewInit() {
        self.backgroundColor = UIColor(white: 0.96, alpha: 1)

        // Create a set of subviews
        for _ in 0..<imageViewCount {
            self.addImageView(animated: false)
        }

        self.layout = YOLayout(layoutBlock: { [unowned self] (layout: YOLayout, size) -> CGSize in
            var angle : CGFloat = 0;
            let center = CGPoint(x: size.width / 2, y: size.height / 2)
            let subviewSize = CGSize(width: 44, height: 44)

            let radius : CGFloat;
            if (size.width < size.height) {
                radius = size.width / 2 - subviewSize.width / 2
            } else {
                radius = size.height / 2 - subviewSize.width / 2
            }

            // Lay out subviews in a circle around center
            for imageView in self.imageViews {
                let subviewCenter = CGPoint(x: center.x + radius * CGFloat(cosf(Float(angle))), y: center.y + radius * CGFloat(sinf(Float(angle))))
                layout.setFrame(CGRect(x: subviewCenter.x - subviewSize.width / 2, y: subviewCenter.y - subviewSize.height / 2, width: subviewSize.width, height: subviewSize.height), view:imageView)
                angle += CGFloat((2 * M_PI) / Double(self.imageViews.count))
            }

            // Always lay out in a square contained by size (aspect fit)
            if (size.width < size.height) {
                return CGSize(width: size.width, height: size.width)
            } else {
                return CGSize(width: size.height, height: size.height)
            }
        })
    }

    func addImageView(animated: Bool) {
        let image = UIImage(named: "information.png", in: Bundle(for: CircleLayoutView.self), compatibleWith: nil)
        let imageView = UIImageView(image: image)
        self.addSubview(imageView)
        self.imageViews.append(imageView)
        if animated {
            // Fade in the imageView
            imageView.alpha = 0
            // Set the initial frame to the center of the view
            imageView.frame = YOLayout.frame(forView: imageView, in: self.bounds, options: [.sizeToFit, .alignCenter])
            UIView.animate(withDuration: 0.3, animations: {
                imageView.alpha = 1
                self.layoutView()
            })
        }
    }

    func removeImageView(animated: Bool) {
        let imageView = self.imageViews.popLast()
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                // Fade out the imageView
                imageView?.alpha = 0
                // Set the final frame to the center of the view
                imageView?.frame = YOLayout.frame(forView: imageView, in: self.bounds, options: [.sizeToFit, .alignCenter])
                self.layoutView()
            }, completion: { (finished) in
                imageView?.removeFromSuperview()
            })
        } else {
            imageView?.removeFromSuperview()
        }
    }
}
