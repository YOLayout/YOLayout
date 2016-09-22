//
//  YOLayout+Internal.h
//  YOLayoutExample
//
//  Created by John Boiles on 8/2/16.
//  Copyright © 2016 YOLayout. All rights reserved.
//

#import "YOLayout.h"

/*!
 Internal, private-ish methods for YOLayout.

 Generally, YOLayout users won't need to use, or think about these methods, but you can choose
 to import this file if you want to do something fancy.
 */
@interface YOLayout (Internal)

/*!
 Layout the subviews.

 @param size Size to layout in
 */
- (CGSize)layoutSubviews:(CGSize)size;

/*!
 Size that fits.

 @param size Size to layout in.
 @result The size needed to display the view
 */
- (CGSize)sizeThatFits:(CGSize)size;

/*!
 If layout is required. Otherwise cached value may be returned.
 This should be called when a views data changes.
 */
- (void)setNeedsLayout;

/*!
 YOLayout can layout YOLayouts. To do this, YOLayout must, itself, be able to accept a frame.
 All subviews of the layout are offset by the frame's origin. Yo dawg I heard you like YOLayouts...

 @param frame Frame to layout in.
 */
- (void)setFrame:(CGRect)frame;

@end
