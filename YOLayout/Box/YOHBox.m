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
      CGSize viewSize = [subview sizeThatFits:CGSizeMake(size.width - x, size.height)];

      CGSize minSize = yself.minSize;
      NSString *identifier = [subview respondsToSelector:@selector(identifier)] ? [subview identifier] : nil;
      if (identifier) {
        NSDictionary *viewOptions = yself.options[identifier];
        if (!!viewOptions[@"minSize"]) minSize = [self parseMinSize:viewOptions];
      }

      viewSize.width = MAX(viewSize.width, minSize.width);
      viewSize.height = MAX(viewSize.height, minSize.height);
      [layout setFrame:CGRectMake(x, y, viewSize.width, viewSize.height) view:subview];
      x += viewSize.width;
      maxHeight = MAX(viewSize.height, maxHeight);
      if (++index != subviews.count) x += yself.spacing;

    }
    y += maxHeight + yself.insets.bottom;

    // Re-position for alignment
    CGFloat position = 0;
    if (self.horizontalAlignment == YOHorizontalAlignmentRight) {
      position = size.width - x - yself.insets.right;
    } else if (self.horizontalAlignment == YOHorizontalAlignmentCenter) {
      position = ceilf(size.width/2.0 - x/2.0);
    }

    if (position > 0) {
      for (id subview in subviews) {
        CGRect frame = [subview frame];
        frame.origin.x += position;
        [layout setFrame:frame view:subview];
      }
    }

    return CGSizeMake(MAX(x, size.width), MAX(y, size.height));
  }];
}

- (void)setOptions:(NSDictionary *)options {
  [super setOptions:options];

  NSString *ha = options[@"horizontalAlignment"];
  if ([ha isEqualToString:@"right"]) self.horizontalAlignment = YOHorizontalAlignmentRight;
  else if ([ha isEqualToString:@"center"]) self.horizontalAlignment = YOHorizontalAlignmentCenter;
  else if ([ha isEqualToString:@"left"]) self.horizontalAlignment = YOHorizontalAlignmentLeft;
}

@end
