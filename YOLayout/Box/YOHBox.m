//
//  YOHBox.m
//  YOLayoutExample
//
//  Created by Gabriel on 3/13/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "YOHBox.h"

@implementation YOHBox

- (void)viewInit {
  [super viewInit];

  YOSelf yself = self;
  self.viewLayout = [YOLayout layoutWithLayoutBlock:^(id<YOLayout> layout, CGSize size) {
    CGFloat x = yself.insets.left;
    NSInteger index = 0;
    CGFloat y = yself.insets.top;
    CGFloat maxHeight = 0;
    NSArray *subviews = [yself subviews];
    for (id subview in subviews) {
      CGRect viewFrame = [layout sizeToFitInFrame:CGRectMake(x, y, size.width, size.height) view:subview];
      x += viewFrame.size.width;
      maxHeight = MAX(viewFrame.size.height, maxHeight);
      if (++index != subviews.count) x += yself.spacing;

    }
    x += yself.insets.right;
    y += maxHeight + yself.insets.bottom;

    return CGSizeMake(MAX(x, size.width), MAX(y, size.height));
  }];
}

@end
