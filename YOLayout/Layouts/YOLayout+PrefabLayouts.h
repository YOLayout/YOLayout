//
// Created by John Boiles on 7/28/16.
// Copyright (c) 2016 YOLayout. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YOLayout.h"

//! A collection of pre-built layout objects for convenience.
@interface YOLayout (PrefabLayouts)

/*!
 A layout which makes the specified subview fill the full size.

 @param subview The subview to layout
 @param Layout
 */
+ (YOLayout *)fill:(id)subview;

/*!
 A layout which makes the specified subview centered.

 @param subview The subview to center
 @param Layout
 */
+ (YOLayout *)center:(id)subview;

/*!
 A layout which makes the specified subview size to fit vertically.

 @param subview The subview to layout
 @param Layout
 */
+ (YOLayout *)fitVertical:(id)subview;

/*!
 A layout which makes the specified subview size to fit horizontally.

 @param subview The subview to layout
 @param Layout
 */
+ (YOLayout *)fitHorizontal:(id)subview;

@end