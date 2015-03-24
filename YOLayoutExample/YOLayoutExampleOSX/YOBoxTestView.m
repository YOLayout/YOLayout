//
//  YOBoxTestView.m
//  YOLayoutExample
//
//  Created by Gabriel on 3/13/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "YOBoxTestView.h"

#import "YONSButton.h"
#import "YONSLabel.h"

@implementation YOBoxTestView

- (void)viewInit {
  [super viewInit];

  YOVBox *contentView = [YOVBox box:@{@"spacing": @(10), @"insets": @(40)}];
  [self addSubview:contentView];

  YONSLabel *label1 = [[YONSLabel alloc] init];
  [label1 setText:@"Box Model Test" font:[NSFont boldSystemFontOfSize:16] color:NSColor.blackColor alignment:NSCenterTextAlignment];
  [contentView addSubview:label1];

  YONSLabel *label2 = [[YONSLabel alloc] init];
  [label2 setText:@"PBR&B Intelligentsia shabby chic. Messenger bag flexitarian cold-pressed VHS 90's. Tofu chillwave pour-over Marfa cold-pressed, kogi bespoke High Life semiotics readymade authentic wolf sriracha craft beer. Next level direct trade shabby chic vegan cliche. Mlkshk butcher church-key cornhole 3 wolf moon, YOLO cold-pressed cronut " font:[NSFont systemFontOfSize:14] color:NSColor.blackColor alignment:NSLeftTextAlignment];
  [contentView addSubview:label2];

  YOHBox *buttons = [YOHBox box:@{@"spacing": @(10), @"insets": @"0,40,20,40"}];

  YONSButton *button1 = [YONSButton buttonWithText:@"Button"];
  [buttons addSubview:button1];

  YONSButton *button2 = [YONSButton buttonWithText:@"Another Button"];
  [buttons addSubview:button2];

  YONSButton *button3 = [YONSButton buttonWithText:@"More Button"];
  [buttons addSubview:button3];

  [contentView addSubview:buttons];
}

@end
