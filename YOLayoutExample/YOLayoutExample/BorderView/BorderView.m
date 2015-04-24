//
//  BorderView.m
//  YOLayoutExample
//
//  Created by Gabriel on 2/19/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "BorderView.h"

#import "YOBorderLayout.h"

@implementation BorderView

- (void)viewInit {
  [super viewInit];
  self.backgroundColor = [UIColor lightGrayColor];

  UILabel *topView = [[UILabel alloc] init];
  topView.font = [UIFont systemFontOfSize:20];
  topView.text = @"Top View";
  topView.numberOfLines = 0;
  topView.textAlignment = NSTextAlignmentCenter;
  topView.backgroundColor = [UIColor redColor];
  [self addSubview:topView];

  UILabel *centerView = [[UILabel alloc] init];
  centerView.font = [UIFont systemFontOfSize:20];
  centerView.text = @"Center View";
  centerView.numberOfLines = 0;
  centerView.textAlignment = NSTextAlignmentCenter;
  centerView.backgroundColor = [UIColor blueColor];
  centerView.textColor = [UIColor whiteColor];
  [self addSubview:centerView];

  UILabel *bottomView = [[UILabel alloc] init];
  bottomView.font = [UIFont systemFontOfSize:20];
  bottomView.text = @"Bottom View";
  bottomView.numberOfLines = 0;
  bottomView.textAlignment = NSTextAlignmentCenter;
  bottomView.backgroundColor = [UIColor orangeColor];
  [self addSubview:bottomView];

  self.layout = [YOBorderLayout layoutWithCenter:centerView top:@[topView] bottom:@[bottomView] insets:UIEdgeInsetsMake(20, 20, 20, 20) spacing:10];
}

@end
