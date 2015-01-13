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
        self.edgesForExtendedLayout = .None;
        self.title = "Swift Circle View"
    }

    override func loadView() {
        super.loadView()

        let swiftView = CircleLayoutView()

        let informationLabel = UILabel()
        informationLabel.textAlignment = .Center
        informationLabel.lineBreakMode = .ByWordWrapping
        informationLabel.numberOfLines = 0
        informationLabel.text = "With YOLayout, you can build any layout you can imagine mathematically. The following view, written in Swift, uses trigonometry to layout subviews in a circle around the center. Try rotating the device."

        // Use a simple container view to hold the informationLabel and the circleView after it sizes to fit
        let containerView = YOView()
        containerView.backgroundColor = UIColor.whiteColor()
        containerView.layout = YOLayout(layoutBlock: { (layout: YOLayoutProtocol!, size) -> CGSize in
            var y : CGFloat = 10;

            y += layout.setFrame(CGRectMake(10, y, size.width - 20, 100), view: informationLabel, options:.SizeToFitVertical).size.height
            y += 5

            layout.setFrame(CGRectMake(5, y, size.width - 10 , size.height - y - 5), view:swiftView, options:.SizeToFit | .AlignCenter)

            return size
        })
        containerView.addSubview(swiftView)
        containerView.addSubview(informationLabel)

        self.view = containerView;
    }

}
