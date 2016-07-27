//
//  CircleLayoutView.swift
//  YOLayoutExample
//
//  Created by John Boiles on 1/9/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

//! A view lays out its subviews in a circle.. in Swift!
class CircleLayoutView: YOView {
    var imageViews = NSMutableArray()

    override func viewInit() {
        self.backgroundColor = UIColor(white: 0.96, alpha: 1)

        // Create a set of subviews
        for _ in 0...7 {
            let imageView = UIImageView(image: UIImage(named: "information.png"))
            self.addSubview(imageView)
        }

        self.layout = YOLayout(layoutBlock: { [unowned self] (layout : YOLayoutProtocol!, size) -> CGSize in
            var angle : CGFloat = 0;
            let center = CGPointMake(size.width / 2, size.height / 2)
            let subviewSize = CGSizeMake(44, 44)

            // TODO: Switch this to `let` when Swift 1.2 is officially released
            var radius : CGFloat;
            if (size.width < size.height) {
                radius = size.width / 2 - subviewSize.width / 2
            } else {
                radius = size.height / 2 - subviewSize.width / 2
            }

            // Lay out subviews in a circle around center
            for subview in self.subviews {
                let subviewCenter = CGPointMake(center.x + radius * CGFloat(cosf(Float(angle))), center.y + radius * CGFloat(sinf(Float(angle))))
                layout.setFrame(CGRectMake(subviewCenter.x - subviewSize.width / 2, subviewCenter.y - subviewSize.height / 2, subviewSize.width, subviewSize.height), view:subview)
                angle += CGFloat(M_PI_4)
            }

            // Always lay out in a square contained by size (aspect fit)
            if (size.width < size.height) {
                return CGSizeMake(size.width, size.width)
            } else {
                return CGSizeMake(size.height, size.height)
            }
        })
    }
}
