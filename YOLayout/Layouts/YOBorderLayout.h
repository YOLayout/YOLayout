//
//  YOBorderLayout.h
//  YOLayoutExample
//
//  Created by Gabriel on 4/24/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YOLayout_IMP.h"

@interface YOBorderLayout : YOLayout

@property UIEdgeInsets insets;
@property CGFloat spacing;
@property CGSize maxSize;

// Center view (fills all the space it can)
@property id center;

+ (instancetype)layout;

+ (instancetype)layoutWithCenter:(id)center top:(NSArray *)top bottom:(NSArray *)bottom;
+ (instancetype)layoutWithCenter:(id)center top:(NSArray *)top bottom:(NSArray *)bottom insets:(UIEdgeInsets)insets spacing:(CGFloat)spacing;
+ (instancetype)layoutWithCenter:(id)center top:(NSArray *)top bottom:(NSArray *)bottom insets:(UIEdgeInsets)insets spacing:(CGFloat)spacing maxSize:(CGSize)maxSize;

- (void)addToTop:(id)top;

- (void)addToBottom:(id)bottom;

@end
