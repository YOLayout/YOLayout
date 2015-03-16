//
//  BoxView.m
//  YOLayoutExample
//
//  Created by Gabriel on 3/16/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "BoxView.h"

@implementation BoxView

- (void)viewInit {
  [super viewInit];
  self.backgroundColor = UIColor.whiteColor;

  YOVBox *contentView = [YOVBox box:@{@"spacing": @(10), @"insets": @(20)}];
  [self addSubview:contentView];

  UILabel *label1 = [[UILabel alloc] init];
  label1.text = @"Box Model Test";
  label1.font = [UIFont boldSystemFontOfSize:20];
  label1.textAlignment = NSTextAlignmentCenter;
  [contentView addSubview:label1];

  UILabel *label2 = [[UILabel alloc] init];
  label2.font = [UIFont systemFontOfSize:14];
  label2.numberOfLines = 0;
  label2.text = @"PBR&B Intelligentsia shabby chic. Messenger bag flexitarian cold-pressed VHS 90's. Tofu chillwave pour-over Marfa cold-pressed, kogi bespoke High Life semiotics readymade authentic wolf sriracha craft beer. Next level direct trade shabby chic vegan cliche. Mlkshk butcher church-key cornhole 3 wolf moon, YOLO cold-pressed cronut";
  [contentView addSubview:label2];

  YOHBox *buttons = [YOHBox box:@{@"spacing": @(20), @"insets": YOBoxInsets(20, 0, 20, 0)}];

  UIButton *button1 = [self buttonWithText:@"Button"];
  [buttons addSubview:button1];

  UIButton *button2 = [self buttonWithText:@"Button (2)"];
  [buttons addSubview:button2];

  UIButton *button3 = [self buttonWithText:@"Button"];
  [buttons addSubview:button3];

  [contentView addSubview:buttons];
}

- (UIButton *)buttonWithText:(NSString *)text {
  UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
  button.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
  [button setTitle:text forState:UIControlStateNormal];
  button.layer.borderWidth = 1.0;
  button.layer.borderColor = UIColor.grayColor.CGColor;
  button.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10);
  return button;
}

@end
