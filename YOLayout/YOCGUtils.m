//
//  YOCGUtils.m
//  YOLayout
//
//  Created by Gabriel Handford on 10/29/13.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

#include "YOCGUtils.h"


#define YOCGIsEqualWithAccuracy(n1, n2, accuracy) (n1 >= (n2-accuracy) && n1 <= (n2+accuracy))

CGPoint YOCGPointToCenterX(CGSize size, CGSize inSize) {
  CGPoint p = CGPointMake(roundf((inSize.width - size.width) / 2.0f), 0);
  if (p.x < 0.0f) p.x = 0.0f;
  return p;
}

CGPoint YOCGPointToCenterY(CGSize size, CGSize inSize) {
  CGPoint p = CGPointMake(0, roundf((inSize.height - size.height) / 2.0f));
  if (p.y < 0.0f) p.y = 0.0f;
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

CGRect YOCGRectSetX(CGRect rect, CGFloat x) {
  rect.origin.x = x;
  return rect;
}

CGRect YOCGRectSetY(CGRect rect, CGFloat y) {
  rect.origin.y = y;
  return rect;
}
