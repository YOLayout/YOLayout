//
//  YOVBox.m
//  YOLayoutExample
//
//  Created by Gabriel on 3/13/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "YOVBox.h"

@implementation YOVBox

- (void)viewInit {
  [super viewInit];

  YOSelf yself = self;
#if TARGET_OS_IPHONE
  self.layout = [YOLayout layoutWithLayoutBlock:^(id<YOLayout> layout, CGSize size) {
#else
    self.viewLayout = [YOLayout layoutWithLayoutBlock:^(id<YOLayout> layout, CGSize size) {
#endif

    CGFloat y = yself.insets.top;
    NSInteger index = 0;
    NSArray *subviews = [yself subviews];
    for (id subview in subviews) {
      CGRect frame = [subview frame];
      y += [layout sizeToFitVerticalInFrame:CGRectMake(yself.insets.left, y, size.width - yself.insets.left - yself.insets.right, frame.size.height) view:subview].size.height;
      if (++index != subviews.count) y += yself.spacing;
    }
    y += yself.insets.bottom;
    return CGSizeMake(size.width, y);
  }];
}

@end
