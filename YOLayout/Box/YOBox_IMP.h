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
#else
#import "YONSView.h"
#endif

@interface YOBox : YOView

@property UIEdgeInsets insets;
@property CGFloat spacing;
@property CGSize minSize;
@property CGSize maxSize;
@property (nonatomic) NSDictionary *options;

+ (instancetype)box;
+ (instancetype)box:(NSDictionary *)options;

- (NSArray *)parseOption:(NSString *)option isFloat:(BOOL)isFloat minCount:(NSInteger)minCount;

- (void)setOptions:(NSDictionary *)options;

- (CGSize)parseMinSize:(NSDictionary *)options;
- (CGSize)parseMaxSize:(NSDictionary *)options;

@end
