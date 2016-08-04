//
//  YOCGUtils.m
//  YOLayout
//
//  Created by Gabriel Handford on 10/29/13.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

#include "YOCGUtils.h"
#if TARGET_OS_IPHONE
@import UIKit;
#else
@import AppKit;
#endif


#define YOCGIsEqualWithAccuracy(n1, n2, accuracy) (n1 >= (n2-accuracy) && n1 <= (n2+accuracy))

CGPoint YOCGPointToCenterX(CGSize size, CGSize inSize) {
  CGPoint p = CGPointMake((inSize.width - size.width) / 2.0f, 0);
  return p;
}

CGPoint YOCGPointToCenterY(CGSize size, CGSize inSize) {
  CGPoint p = CGPointMake(0, (inSize.height - size.height) / 2.0f);
  return p;
}

BOOL YOCGPointIsEqual(CGPoint p1, CGPoint p2) {
  return (YOCGIsEqualWithAccuracy(p1.x, p2.x, 0.0001) && YOCGIsEqualWithAccuracy(p1.y, p2.y, 0.0001));
}

BOOL YOCGSizeIsEqual(CGSize size1, CGSize size2) {
  return (YOCGIsEqualWithAccuracy(size1.height, size2.height, 0.0001) && YOCGIsEqualWithAccuracy(size1.width, size2.width, 0.0001));
}

BOOL YOCGRectIsEqual(CGRect rect1, CGRect rect2) {
  return (YOCGPointIsEqual(rect1.origin, rect2.origin) && YOCGSizeIsEqual(rect1.size, rect2.size));
}

inline CGFloat YOCGFloatPixelRound(CGFloat value) {
#if TARGET_OS_IPHONE
    CGFloat scale = [[UIScreen mainScreen] scale];
#else
    CGFloat scale = [[NSScreen mainScreen] backingScaleFactor];
#endif
    return roundf(value * scale) / scale;
}

inline CGRect YOCGRectPixelRound(CGRect rect) {
  return CGRectMake(YOCGFloatPixelRound(rect.origin.x), YOCGFloatPixelRound(rect.origin.y), YOCGFloatPixelRound(rect.size.width), YOCGFloatPixelRound(rect.size.height));
}

inline CGSize YOCGSizePixelRound(CGSize size) {
    return CGSizeMake(YOCGFloatPixelRound(size.width), YOCGFloatPixelRound(size.height));
}

inline CGPoint YOCGPointPixelRound(CGPoint point) {
  return CGPointMake(YOCGFloatPixelRound(point.x), YOCGFloatPixelRound(point.y));
}
