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
#if TARGET_OS_IPHONE
  self.layout = [YOLayout layoutWithLayoutBlock:^(id<YOLayout> layout, CGSize size) {
#else
  self.viewLayout = [YOLayout layoutWithLayoutBlock:^(id<YOLayout> layout, CGSize size) {
#endif
    CGFloat x = yself.insets.left;
    NSInteger index = 0;
    CGFloat y = yself.insets.top;
    CGFloat maxHeight = 0;
    NSArray *subviews = [yself subviews];
    for (id subview in subviews) {
      CGRect frame = [subview frame];
      CGRect viewFrame = [layout setFrame:CGRectMake(x, y, frame.size.width - yself.insets.left - yself.insets.right, size.height - yself.insets.top - yself.insets.bottom) view:subview options:YOLayoutOptionsSizeToFitHorizontal];
      x += viewFrame.size.width;
      maxHeight = MAX(viewFrame.size.height, maxHeight);
      if (++index != subviews.count) x += yself.spacing;

    }
    x += yself.insets.right;
    y += maxHeight + yself.insets.bottom;
    return CGSizeMake(x, MAX(y, size.height));
  }];
}

@end
