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

  YOVBox *labelsView = [YOVBox box:@{@"spacing": @(10), @"insets": @"20,20,0,20"}];
  {
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"Box Model Test";
    label1.font = [UIFont boldSystemFontOfSize:20];
    label1.textAlignment = NSTextAlignmentCenter;
    [labelsView addSubview:label1];

    UILabel *label2 = [[UILabel alloc] init];
    label2.font = [UIFont systemFontOfSize:14];
    label2.numberOfLines = 0;
    label2.text = @"PBR&B Intelligentsia shabby chic. Messenger bag flexitarian cold-pressed VHS 90's. Tofu chillwave pour-over Marfa cold-pressed, kogi bespoke High Life semiotics readymade authentic wolf sriracha craft beer. Next level direct trade shabby chic vegan cliche. Mlkshk butcher church-key cornhole 3 wolf moon, YOLO cold-pressed cronut";
    [labelsView addSubview:label2];
  }
  [self addSubview:labelsView];

  YOHBox *buttons = [YOHBox box:@{@"spacing": @(20), @"insets": @"10,20,10,20", @"minSize": @"50,50", @"horizontalAlignment": @"right"}];
  {
    UIButton *button1 = [self buttonWithText:@"A"];
    [buttons addSubview:button1];
    UIButton *button2 = [self buttonWithText:@"B"];
    [buttons addSubview:button2];
    UIButton *button3 = [self buttonWithText:@"C"];
    [buttons addSubview:button3];
  }
  [self addSubview:buttons];

  YOHBox *buttonsCenter = [YOHBox box:@{@"spacing": @(20), @"horizontalAlignment": @"center"}];
  {
    [buttonsCenter addSubview:[self buttonWithText:@"D"]];
    [buttonsCenter addSubview:[self buttonWithText:@"E"]];
    [buttonsCenter addSubview:[self buttonWithText:@"F"]];
  }
  [self addSubview:buttonsCenter];

  YOBox *box = [YOBox box:@{@"insets": @(20), @"spacing": @(10)}];
  {
    [box addSubview:[self buttonWithText:@"Left1"]];
    [box addSubview:[self buttonWithText:@"Left2"]];
    YOHBox *right = [YOHBox box:@{@"spacing": @(10), @"minSize": @"0,100", @"horizontalAlignment": @"right"}];
    {
      [right addSubview:[self buttonWithText:@"Right1"]];
      [right addSubview:[self buttonWithText:@"Right2"]];
      [box addSubview:right];
    }
  }
  [self addSubview:box];
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
