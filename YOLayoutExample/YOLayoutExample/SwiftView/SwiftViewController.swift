//
//  SwiftViewController.swift
//  YOLayoutExample
//
//  Created by John Boiles on 1/9/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

import UIKit

class SwiftViewController: UIViewController {

    let swiftView = CircleLayoutView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge();
        self.title = "Swift Circle View"
    }

    override func loadView() {
        super.loadView()

        let informationLabel = UILabel()
        informationLabel.textAlignment = .center
        informationLabel.lineBreakMode = .byWordWrapping
        informationLabel.numberOfLines = 0
        informationLabel.text = "With YOLayout, you can build any layout you can imagine mathematically. The following view, written in Swift, uses trigonometry to layout subviews in a circle around the center. Try rotating the device."

        let addViewButton = UIButton()
        addViewButton.setTitle("Add View", for: .normal)
        addViewButton.setTitleColor(UIColor.blue, for: .normal)
        addViewButton.addTarget(self, action: #selector(addView), for: .touchUpInside)

        let removeViewButton = UIButton()
        removeViewButton.setTitle("Remove View", for: .normal)
        removeViewButton.setTitleColor(UIColor.blue, for: .normal)
        removeViewButton.addTarget(self, action: #selector(removeView), for: .touchUpInside)

        // Use a simple container view to hold the informationLabel and the circleView after it sizes to fit
        let containerView = YOView()
        containerView.backgroundColor = UIColor.white
        containerView.layout = YOLayout(layoutBlock: { [unowned self] (layout: YOLayout, size) -> CGSize in
            var y : CGFloat = 10;

            y += layout.setFrame(CGRect(x: 10, y: y, width: size.width - 20, height: 100), view: informationLabel, options:.sizeToFitVertical).height

            let buttonRow = YOLayout(layoutBlock: { (layout: YOLayout, size) -> CGSize in
                let buttonWidth : CGFloat = size.width / 2 - 5
                layout.setFrame(CGRect(x: 0, y: 0, width: buttonWidth, height: size.height), view: addViewButton)
                layout.setFrame(CGRect(x: buttonWidth + 10, y: 0, width: buttonWidth, height: size.height), view: removeViewButton, options:.alignRight)
                return size
            })

            y += layout.setFrame(CGRect(x: 10, y: y, width: size.width - 20, height: 44), view: buttonRow).height
            y += 5

            layout.setFrame(CGRect(x: 5, y: y, width: size.width - 10 , height: size.height - y - 5), view:self.swiftView, options:[.sizeToFit, .alignCenter])

            return size
        })
        containerView.addSubview(swiftView)
        containerView.addSubview(informationLabel)
        containerView.addSubview(addViewButton)
        containerView.addSubview(removeViewButton)

        self.view = containerView;
    }

    func addView() {
        swiftView.addImageView(animated: true)
    }

    func removeView() {
        swiftView.removeImageView(animated: true)
    }
}
