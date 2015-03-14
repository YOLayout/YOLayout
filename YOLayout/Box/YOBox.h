//
//  YOBox.h
//  YOLayoutExample
//
//  Created by Gabriel on 3/13/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE
#import "YOView.h"
@interface YOBox : YOView
#else
#import "YONSView.h"
@interface YOBox : YONSView
#endif

@property UIEdgeInsets insets;
@property CGFloat spacing;

+ (instancetype)box;
+ (instancetype)box:(NSDictionary *)options;

- (void)setOptions:(NSDictionary *)options;

@end
