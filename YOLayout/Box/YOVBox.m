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
  self.viewLayout = [YOLayout layoutWithLayoutBlock:^(id<YOLayout> layout, CGSize size) {
    CGFloat y = yself.insets.top;
    NSInteger index = 0;
    NSArray *subviews = [yself subviews];

    for (id subview in subviews) {
      NSString *identifier = [subview respondsToSelector:@selector(identifier)] ? [subview identifier] : nil;

      CGSize viewSize = [layout sizeThatFits:CGSizeMake(size.width - yself.insets.left - yself.insets.right, 0) view:subview options:YOLayoutOptionsSizeToFitVertical];

      CGSize minSize = yself.minSize;
      CGSize maxSize = yself.maxSize;
      NSDictionary *viewOptions = yself.options[identifier];
      if (identifier) {
        if (!!viewOptions[@"maxSize"]) maxSize = [self parseMaxSize:viewOptions];
        if (!!viewOptions[@"minSize"]) minSize = [self parseMinSize:viewOptions];
      }

      viewSize = [self parseSize:viewOptions viewSize:viewSize inSize:size];

      viewSize.width = MAX(viewSize.width, minSize.width);
      viewSize.height = MAX(viewSize.height, minSize.height);

      if (maxSize.width != 0) viewSize.width = MIN(viewSize.width, maxSize.width);

      CGFloat x;
      if (self.horizontalAlignment == YOHorizontalAlignmentRight) {
        x = size.width - viewSize.width - yself.insets.right;
      } else if (self.horizontalAlignment == YOHorizontalAlignmentCenter) {
        x = ceilf(size.width/2.0 - viewSize.width/2.0);
      } else {
        x = yself.insets.left;
      }

      y += [layout setFrame:CGRectMake(x, y, viewSize.width, viewSize.height) view:subview].size.height;

      if (++index != subviews.count) y += yself.spacing;
    }
    y += yself.insets.bottom;

    size.height = y;

    CGSize minSize = self.minSize;
    size.width = MAX(size.width, minSize.width);
    size.height = MAX(size.height, minSize.height);

    return size;
  }];
}

@end
