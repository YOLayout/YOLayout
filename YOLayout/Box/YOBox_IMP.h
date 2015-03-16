//
//  YOBox.h
//  YOLayoutExample
//
//  Created by Gabriel on 3/13/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import <Foundation/Foundation.h>

#define YOBoxInsets(TOP, RIGHT, BOTTOM, LEFT) (@[@(TOP), @(LEFT), @(BOTTOM), @(RIGHT)])

#if TARGET_OS_IPHONE
#import "YOView.h"
#else
#import "YONSView.h"
#endif

@interface YOBox : YOView

@property UIEdgeInsets insets;
@property CGFloat spacing;

+ (instancetype)box;
+ (instancetype)box:(NSDictionary *)options;

- (void)setOptions:(NSDictionary *)options;

@end
