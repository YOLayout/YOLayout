//
//  UIView+YOLayout.h
//  YOLayoutExample
//
//  Created by Lucas Yan on 8/1/16.
//  Copyright © 2016 YOLayout. All rights reserved.
//

@import UIKit;

@class YOLayout;

@interface UIView (YOLayout)

@property (nonatomic) YOLayout *layout;

+ (void)useYOLayout;
- (void)viewInit;
- (void)layoutView;

@end
