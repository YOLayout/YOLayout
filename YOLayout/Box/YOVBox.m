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
      CGRect frame = [subview frame];

      NSString *identifier = [subview respondsToSelector:@selector(identifier)] ? [subview identifier] : nil;
      CGSize maxSize = yself.maxSize;
      if (identifier) {
        NSDictionary *viewOptions = yself.options[[subview identifier]];
        if (!!viewOptions[@"maxSize"]) maxSize = [self parseMaxSize:viewOptions];
      }
      if (maxSize.width != 0) size.width = MIN(size.width, maxSize.width);

      CGRect inFrame = CGRectMake(yself.insets.left, y, size.width - yself.insets.left - yself.insets.right, frame.size.height);      
      y += [layout sizeToFitVerticalInFrame:inFrame view:subview].size.height;
      if (++index != subviews.count) y += yself.spacing;
    }
    y += yself.insets.bottom;
    return CGSizeMake(size.width, y);
  }];
}

@end
