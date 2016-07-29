//
//  BorderView.m
//  YOLayoutExample
//
//  Created by Gabriel on 2/19/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "BorderView.h"

#import "YOVBorderLayout.h"
#import "YOHBorderLayout.h"

@implementation BorderView

- (void)viewInit {
  [super viewInit];
  self.backgroundColor = UIColor.blackColor;

  UILabel *topView = [self label:@"Top" backgroundColor:UIColor.redColor];
  [self addSubview:topView];

  YOView *centerView = [YOView new];
  {
    UILabel *leftLabel = [self label:@"Left" backgroundColor:UIColor.greenColor];
    [centerView addSubview:leftLabel];
    UILabel *centerLabel = [self label:@"Center" backgroundColor:UIColor.blueColor];
    [centerView addSubview:centerLabel];
    UILabel *rightLabel = [self label:@"Right" backgroundColor:UIColor.cyanColor];
    [centerView addSubview:rightLabel];

    centerView.layout = [YOHBorderLayout layoutWithCenter:centerLabel left:@[leftLabel] right:@[rightLabel] insets:UIEdgeInsetsZero spacing:10];
  }
  [self addSubview:centerView];

  UILabel *bottomView = [self label:@"Bottom" backgroundColor:UIColor.orangeColor];
  [self addSubview:bottomView];

  self.layout = [YOVBorderLayout layoutWithCenter:centerView top:@[topView] bottom:@[bottomView] insets:UIEdgeInsetsMake(20, 20, 20, 20) spacing:10];
}

- (UILabel *)label:(NSString *)text backgroundColor:(UIColor *)backgroundColor {
  UILabel *label = [[UILabel alloc] init];
  label.font = [UIFont systemFontOfSize:20];
  label.text = text;
  label.numberOfLines = 0;
  label.textAlignment = NSTextAlignmentCenter;
  label.backgroundColor = backgroundColor;
  label.textColor = [UIColor whiteColor];
  return label;
}

@end
