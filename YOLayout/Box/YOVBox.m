//
//  YOVBox.m
//  YOLayout
//
//  Created by Gabriel on 3/13/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "YOVBox.h"

@implementation YOVBox

- (void)viewInit {
  [super viewInit];
  self.identifier = @"VBox";
  self.viewLayout = [YOLayout layoutWithLayoutBlock:[YOVBox verticalLayout:self]];
}

+ (YOLayoutBlock)verticalLayout:(YOBox *)box {
  return ^(id<YOLayout> layout, CGSize size) {
    CGFloat y = box.insets.top;
    NSInteger index = 0;
    NSArray *subviews = [box subviewsForLayout];
    if (box.debug) NSLog(@"%@ layout %@", box.identifier, YONSStringFromCGSize(size));
    for (id subview in subviews) {
      if (box.ignoreLayoutForHidden && [subview isHidden]) continue;
      NSString *identifier = [subview respondsToSelector:@selector(identifier)] ? [subview identifier] : nil;

      CGSize viewSize = [layout sizeThatFits:CGSizeMake(size.width - box.insets.left - box.insets.right, size.height) view:subview options:YOLayoutOptionsSizeToFitVertical];
      if (box.debug) NSLog(@"- %@ %@", [subview identifier], YONSStringFromCGSize(viewSize));

      CGSize minSize = box.minSize;
      CGSize maxSize = box.maxSize;
      NSDictionary *viewOptions = box.options[identifier];
      if (identifier) {
        if (!!viewOptions[@"maxSize"]) maxSize = [box parseMaxSize:viewOptions];
        if (!!viewOptions[@"minSize"]) minSize = [box parseMinSize:viewOptions];
      }

      viewSize = [box parseSize:viewOptions viewSize:viewSize inSize:size];

      viewSize.width = MAX(viewSize.width, minSize.width);
      viewSize.height = MAX(viewSize.height, minSize.height);

      if (maxSize.width != 0) viewSize.width = MIN(viewSize.width, maxSize.width);

      CGFloat x;
      if (box.horizontalAlignment == YOHorizontalAlignmentRight) {
        x = size.width - viewSize.width - box.insets.right;
      } else if (box.horizontalAlignment == YOHorizontalAlignmentCenter) {
        x = ceilf(size.width/2.0 - viewSize.width/2.0);
      } else {
        x = box.insets.left;
      }

      y += [layout setFrame:CGRectMake(x, y, viewSize.width, viewSize.height) view:subview].size.height;

      if (++index != subviews.count) {
        if (box.debug) NSLog(@"- Spacing %@", @(box.spacing));
        y += box.spacing;
      }
    }
    y += box.insets.bottom;

    size.height = y;

    CGSize minSize = box.minSize;
    size.width = MAX(size.width, minSize.width);
    size.height = MAX(size.height, minSize.height);

    if (box.debug) NSLog(@"%@", YONSStringFromCGSize(size));
    return size;
  };
}

@end

CGSize YOLayoutVertical(YOBox *box, YOLayout *layout, CGSize size) {
  return [YOVBox verticalLayout:box](layout, size);
}
