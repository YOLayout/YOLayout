//
//  BorderView.m
//  YOLayoutExample
//
//  Created by Gabriel on 2/19/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "BorderView.h"

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

  UIEdgeInsets margin = UIEdgeInsetsMake(20, 20, 20, 20);
  CGFloat padding = 10;

  self.layout = [YOLayout layoutWithLayoutBlock:^CGSize(id<YOLayout> layout, CGSize size) {
    // Size inset by margin
    CGSize sizeInset = CGSizeMake(size.width - margin.left - margin.right, size.height - margin.top - margin.bottom);

    CGSize topSize = [topView sizeThatFits:sizeInset];
    CGSize bottomSize = [bottomView sizeThatFits:sizeInset];

    // Calculate the height to fill the center
    CGFloat centerHeight = sizeInset.height - topSize.height - bottomSize.height - (padding * 2);

    // Size and position the views
    CGFloat y = margin.top;
    y += [layout setFrame:CGRectMake(margin.left, y, sizeInset.width, topSize.height) view:topView].size.height + padding;

    y += [layout setFrame:CGRectMake(margin.left, y, sizeInset.width, centerHeight) view:centerView].size.height + padding;

    y += [layout setFrame:CGRectMake(margin.left, y, sizeInset.width, bottomSize.height) view:bottomView].size.height;
    
    return size;
  }];
}

@end
