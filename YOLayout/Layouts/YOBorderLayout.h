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

@property CGSize maxSize;

+ (instancetype)layoutWithCenter:(id)center top:(NSArray *)top bottom:(NSArray *)bottom insets:(UIEdgeInsets)insets spacing:(CGFloat)spacing;

@end
