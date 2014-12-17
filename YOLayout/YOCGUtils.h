//
//  YOLayout.h
//  YOLayout
//
//  Created by Gabriel Handford on 10/29/13.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

@import UIKit;


CGPoint YOCGPointToCenterY(CGSize size, CGSize inSize);

CGPoint YOCGPointToCenter(CGSize size, CGSize inSize);

CGRect YOCGRectSetY(CGRect rect, CGFloat y);

CGRect YOCGRectRightAlignWithRect(CGRect rect, CGRect inRect);

CGRect YOCGRectToCenterInRect(CGSize size, CGRect inRect);

CGRect YOCGRectToCenterYInRect(CGRect rect, CGRect inRect);

BOOL YOCGRectIsEqual(CGRect rect1, CGRect rect2);
