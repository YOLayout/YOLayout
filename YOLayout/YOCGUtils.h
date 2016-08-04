//
//  YOCGUtils.h
//  YOLayout
//
//  Created by Gabriel Handford on 10/29/13.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

@import Foundation;
@import CoreGraphics;


CGPoint YOCGPointToCenterX(CGSize size, CGSize inSize);

CGPoint YOCGPointToCenterY(CGSize size, CGSize inSize);

BOOL YOCGPointIsEqual(CGPoint p1, CGPoint p2);

BOOL YOCGSizeIsEqual(CGSize size1, CGSize size2);

BOOL YOCGRectIsEqual(CGRect rect1, CGRect rect2);

CGFloat YOCGFloatPixelRound(CGFloat value);

CGRect YOCGRectPixelRound(CGRect rect);

CGSize YOCGSizePixelRound(CGSize size);

CGPoint YOCGPointPixelRound(CGPoint point);
