//
//  SwiftViewController.swift
//  YOLayoutExample
//
//  Created by John Boiles on 1/9/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

import UIKit

class SwiftViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge();
        self.title = "Swift Circle View"
    }

    override func loadView() {
        super.loadView()

        let swiftView = CircleLayoutView()

        let informationLabel = UILabel()
        informationLabel.textAlignment = .center
        informationLabel.lineBreakMode = .byWordWrapping
        informationLabel.numberOfLines = 0
        informationLabel.text = "With YOLayout, you can build any layout you can imagine mathematically. The following view, written in Swift, uses trigonometry to layout subviews in a circle around the center. Try rotating the device."

        // Use a simple container view to hold the informationLabel and the circleView after it sizes to fit
        let containerView = YOView()
        containerView.backgroundColor = UIColor.white
        containerView.layout = YOLayout(layoutBlock: { (layout: YOLayout, size) -> CGSize in
            var y : CGFloat = 10;

            y += layout.setFrame(CGRect(x: 10, y: y, width: size.width - 20, height: 100), view: informationLabel, options:.sizeToFitVertical).size.height
            y += 5

            layout.setFrame(CGRect(x: 5, y: y, width: size.width - 10 , height: size.height - y - 5), view:swiftView, options:[.sizeToFit, .alignCenter])

            return size
        })
        containerView.addSubview(swiftView)
        containerView.addSubview(informationLabel)

        self.view = containerView;
    }

}
