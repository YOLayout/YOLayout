//
//  YOCGUtils.c
//  YOLayout
//
//  Created by Gabriel Handford on 10/29/13.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

#include "YOCGUtils.h"


#define YOCGIsEqualWithAccuracy(n1, n2, accuracy) (n1 >= (n2-accuracy) && n1 <= (n2+accuracy))

CGPoint YOCGPointToCenterY(CGSize size, CGSize inSize) {
    CGPoint p = CGPointMake(0, roundf((inSize.height - size.height) / 2.0f));
    if (p.y < 0.0f) p.y = 0.0f;
    return p;
}

CGPoint YOCGPointToCenter(CGSize size, CGSize inSize) {
    // We round otherwise views will anti-alias
    CGPoint p = CGPointMake(roundf((inSize.width - size.width) / 2.0), roundf((inSize.height - size.height) / 2.0f));
    // Allowing negative values here allows us to center a larger view on a smaller view.
    // Though set to 0 if inSize.height was 0
    if (inSize.height == 0.0f) p.y = 0.0f;
    return p;
}

BOOL YOCGPointIsEqual(CGPoint p1, CGPoint p2) {
    return (YOCGIsEqualWithAccuracy(p1.x, p2.x, 0.0001) && YOCGIsEqualWithAccuracy(p1.y, p2.y, 0.0001));
}

BOOL YOCGSizeIsEqual(CGSize size1, CGSize size2) {
    return (YOCGIsEqualWithAccuracy(size1.height, size2.height, 0.0001) && YOCGIsEqualWithAccuracy(size1.width, size2.width, 0.0001));
}

CGRect YOCGRectSetY(CGRect rect, CGFloat y) {
    rect.origin.y = y;
    return rect;
}

CGRect YOCGRectRightAlignWithRect(CGRect rect, CGRect inRect) {
    CGFloat x = inRect.origin.x + inRect.size.width - rect.size.width;
    return CGRectMake(x, rect.origin.y, rect.size.width, rect.size.height);
}

CGRect YOCGRectToCenterInRect(CGSize size, CGRect inRect) {
    CGPoint p = YOCGPointToCenter(size, inRect.size);
    return CGRectMake(p.x + inRect.origin.x, p.y + inRect.origin.y, size.width, size.height);
}

CGRect YOCGRectToCenterYInRect(CGRect rect, CGRect inRect) {
    CGPoint p = YOCGPointToCenterY(rect.size, inRect.size);
    return YOCGRectSetY(rect, p.y + inRect.origin.y);
}

BOOL YOCGRectIsEqual(CGRect rect1, CGRect rect2) {
    return (YOCGPointIsEqual(rect1.origin, rect2.origin) && YOCGSizeIsEqual(rect1.size, rect2.size));
}

