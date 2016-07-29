//
//  YOLayout+Logic.h
//  YOLayout
//
//  Created by John Boiles on 7/28/16.
//  Copyright © 2016 YOLayout. All rights reserved.
//

#import "YOLayout_IMP.h"

//! Internal layout logic for YOLayout. Can also be used to do calculations without a YOLayout instance.
@interface YOLayout (Logic)

/*!
 Calculate a (sub)view's frame.
 
 @param view View object (should implement sizeThatFits: if sizing)
 @param inRect Default frame to set for the view
 @param options Options for setFrame; See YOLayoutOptions for more info
 @result The calculated frame.
 */
+ (CGRect)frameForView:(id)view inRect:(CGRect)inRect options:(YOLayoutOptions)options;

/*!
 Calculate a (sub)view's frame.
 
 @param view View object should implement sizeThatFits:
 @param size Desired size (or size hint if using YOLayoutOptionsSizeToFit)
 @param inRect Rect in which to position the view. `inRect.size` may be different than `size` when using this method with YOLayoutOptionsAlignCenter, YOLayoutOptionsAlignCenterVertical, YOLayoutOptionsAlignRight, etc.
 @param options Options for setFrame; See YOLayoutOptions for more info
 @result The calculated frame.
 */
+ (CGRect)frameForView:(id)view size:(CGSize)size inRect:(CGRect)inRect options:(YOLayoutOptions)options;

/*!
 Calculate a rect given a size and alignment options
 
 @param size Size for output rect
 @param inRect Bounding rect in which to position the size.
 @param options Options for aligning; See YOLayoutOptions for more info
 @result The calculated frame.
 */
+ (CGRect)alignSize:(CGSize)size inRect:(CGRect)inRect options:(YOLayoutOptions)options;

/*!
 Calculate a (sub)view's size.
 
 @param view View object that implements `sizeThatFits:`
 @param size Size hint to pass to `sizeThatFits:`
 @param options Options for sizing; See YOLayoutOptions for more info
 @result The calculated frame.
 */
+ (CGSize)sizeThatFits:(CGSize)size view:(id)view options:(YOLayoutOptions)options;


@end
