//
//  YOHBox.m
//  YOLayout
//
//  Created by Gabriel on 3/13/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "YOHBox.h"

@implementation YOHBox

- (void)viewInit {
  [super viewInit];
  self.identifier = @"HBox";
  self.viewLayout = [YOLayout layoutWithLayoutBlock:[YOHBox horizontalLayout:self]];
}

+ (YOLayoutBlock)horizontalLayout:(YOBox *)box {
  return ^(id<YOLayout> layout, CGSize size) {
    CGFloat x = box.insets.left;
    NSInteger index = 0;
    CGFloat y = box.insets.top;
    CGFloat maxHeight = 0;
    NSArray *subviews = [box subviewsForLayout];
    if (box.debug) NSLog(@"%@ layout %@", box.identifier, YONSStringFromCGSize(size));
    for (id subview in subviews) {
      CGSize viewSize = [subview sizeThatFits:CGSizeMake(size.width - x - box.insets.right, size.height)];
      if (box.debug) NSLog(@"- %@ %@", [subview identifier], YONSStringFromCGSize(viewSize));

      CGSize minSize = box.minSize;
      NSString *identifier = [subview respondsToSelector:@selector(identifier)] ? [subview identifier] : nil;
      if (identifier) {
        NSDictionary *viewOptions = box.options[identifier];
        if (!!viewOptions[@"minSize"]) minSize = [box parseMinSize:viewOptions];
      }

      viewSize.width = MAX(viewSize.width, minSize.width);
      viewSize.height = MAX(viewSize.height, minSize.height);
      [layout setFrame:CGRectMake(x, y, viewSize.width, viewSize.height) view:subview];
      x += viewSize.width;
      maxHeight = MAX(viewSize.height, maxHeight);
      if (++index != subviews.count) x += box.spacing;

    }
    y += maxHeight + box.insets.bottom;

    // Re-position for alignment
    CGFloat position = 0;
    if (box.horizontalAlignment == YOHorizontalAlignmentRight) {
      position = size.width - x - box.insets.right;
    } else if (box.horizontalAlignment == YOHorizontalAlignmentCenter) {
      position = ceilf(size.width/2.0 - x/2.0);
    }

    if (position > 0) {
      for (id subview in subviews) {
        CGRect frame = [subview frame];
        frame.origin.x += position;
        [layout setFrame:frame view:subview];
      }
    }

    size = CGSizeMake(MAX(x, size.width), MAX(y, size.height));
    if (box.debug) NSLog(@"%@", YONSStringFromCGSize(size));
    return size;
  };
}

@end

CGSize YOLayoutHorizontal(YOBox *box, YOLayout *layout, CGSize size) {
  return [YOHBox horizontalLayout:box](layout, size);
}
