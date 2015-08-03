//
//  YOHBorderLayout.h
//  YOLayoutExample
//
//  Created by Gabriel on 8/3/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YOLayout_IMP.h"

@interface YOHBorderLayout : YOLayout

@property UIEdgeInsets insets;
@property CGFloat spacing;

// Center view (fills all the space it can)
@property id center;

+ (instancetype)layout;

+ (instancetype)layoutWithCenter:(id)center left:(NSArray *)left right:(NSArray *)right;
+ (instancetype)layoutWithCenter:(id)center left:(NSArray *)left right:(NSArray *)right insets:(UIEdgeInsets)insets spacing:(CGFloat)spacing;

@end
