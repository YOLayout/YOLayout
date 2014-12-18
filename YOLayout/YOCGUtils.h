//
//  YOLayout.h
//  YOLayout
//
//  Created by Gabriel Handford on 10/29/13.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

#import <UIKit/UIKit.h>


CGPoint YOCGPointToCenterY(CGSize size, CGSize inSize);

CGPoint YOCGPointToCenter(CGSize size, CGSize inSize);

BOOL YOCGSizeIsEqual(CGSize size1, CGSize size2);

BOOL YOCGRectIsEqual(CGRect rect1, CGRect rect2);

CGRect YOCGRectSetY(CGRect rect, CGFloat y);

CGRect YOCGRectRightAlignWithRect(CGRect rect, CGRect inRect);

CGRect YOCGRectToCenterInRect(CGSize size, CGRect inRect);

CGRect YOCGRectToCenterXInRect(CGRect rect, CGRect inRect);

CGRect YOCGRectToCenterYInRect(CGRect rect, CGRect inRect);
