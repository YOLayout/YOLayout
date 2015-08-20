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

typedef NS_ENUM(NSInteger, YOHorizontalAlignment) {
  YOHorizontalAlignmentNone,
  YOHorizontalAlignmentLeft,
  YOHorizontalAlignmentCenter,
  YOHorizontalAlignmentRight
};

@interface YOBox : YOView

@property UIEdgeInsets insets;
@property CGFloat spacing;
@property CGSize minSize;
@property CGSize maxSize;
@property YOHorizontalAlignment horizontalAlignment;
@property BOOL ignoreLayoutForHidden; // Whether to skip layout for hidden subviews; Default: NO
@property BOOL debug; // Will display debug info on layout
@property (nonatomic) NSDictionary *options;

#if TARGET_OS_IPHONE
@property NSString *identifier;
#endif

+ (instancetype)box;
+ (instancetype)box:(NSDictionary *)options;

+ (instancetype)boxWithSize:(CGSize)size;

- (NSArray *)parseOption:(NSString *)option isFloat:(BOOL)isFloat minCount:(NSInteger)minCount;

- (void)setOptions:(NSDictionary *)options;

- (CGSize)parseMinSize:(NSDictionary *)options;
- (CGSize)parseMaxSize:(NSDictionary *)options;

- (CGSize)parseSize:(NSDictionary *)options viewSize:(CGSize)viewSize inSize:(CGSize)inSize;

- (NSArray *)subviewsForLayout;

@end
