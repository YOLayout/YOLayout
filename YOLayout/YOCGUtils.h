//
//  YOCGUtils.h
//  YOLayout
//
//  Created by Gabriel Handford on 10/29/13.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

CGPoint YOCGPointToCenterX(CGSize size, CGSize inSize);

CGPoint YOCGPointToCenterY(CGSize size, CGSize inSize);

BOOL YOCGSizeIsEqual(CGSize size1, CGSize size2);

BOOL YOCGRectIsEqual(CGRect rect1, CGRect rect2);

CGRect YOCGRectSetY(CGRect rect, CGFloat y);
