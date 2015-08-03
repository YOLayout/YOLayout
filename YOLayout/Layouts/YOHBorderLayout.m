//
//  YOHBorderLayout.m
//  YOLayoutExample
//
//  Created by Gabriel on 8/3/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "YOHBorderLayout.h"

@interface YOHBorderLayout ()
@property NSMutableArray *left;
@property NSMutableArray *right;
@end

@implementation YOHBorderLayout

- (instancetype)init {
  if ((self = [super init])) {
    YOSelf yself = self;
    self.layoutBlock = ^(id<YOLayout> layout, CGSize size) {
      UIEdgeInsets insets = yself.insets;
      CGFloat spacing = yself.spacing;
      CGSize sizeInset = CGSizeMake(size.width - insets.left - insets.right, size.height - insets.left - insets.right);

      CGSize leftSizeAll = CGSizeZero;
      for (id leftView in yself.left) {
        CGSize leftSize = [leftView sizeThatFits:sizeInset];//[layout sizeThatFits:sizeInset view:leftView options:YOLayoutOptionsSizeToFitHorizontal];
        leftSizeAll.width += leftSize.width;
        leftSizeAll.height = MAX(leftSizeAll.height, leftSize.height);
      }
      CGSize rightSizeAll = CGSizeZero;
      for (id rightView in yself.right) {
        CGSize rightSize = [rightView sizeThatFits:sizeInset]; //[layout sizeThatFits:sizeInset view:rightView options:YOLayoutOptionsSizeToFitHorizontal];
        rightSizeAll.width += rightSize.width;
        rightSizeAll.height = MAX(rightSizeAll.height, rightSize.height);
      }

      CGSize centerSize = [yself.center sizeThatFits:sizeInset];
      CGFloat centerHeight = MAX(size.height, centerSize.height);

      CGFloat height = MAX(centerHeight, MAX(leftSizeAll.height, rightSizeAll.height));

      CGFloat centerWidth = sizeInset.width - leftSizeAll.width - rightSizeAll.width;
      if ([yself.left count] > 0) centerWidth -= yself.spacing * [yself.left count];
      if ([yself.right count] > 0) centerWidth -= yself.spacing * [yself.right count];

      CGFloat x = insets.left;
      for (id leftView in yself.left) {
        x += [layout sizeToFitHorizontalInFrame:CGRectMake(x, insets.top, sizeInset.width - x, height) view:leftView].size.width + spacing;
      }

      if (yself.center) {
        x += [layout setFrame:CGRectMake(x, insets.top, centerWidth, height) view:yself.center].size.width + spacing;
      } else {
        x += centerWidth;
      }

      for (id rightView in yself.right) {
        x += [layout sizeToFitHorizontalInFrame:CGRectMake(x, insets.top, sizeInset.width -  x, height) view:rightView].size.width + spacing;
      }

      return CGSizeMake(size.width, height);
    };

  }
  return self;
}

+ (instancetype)layout {
  return [[self.class alloc] init];
}

+ (instancetype)layoutWithCenter:(id)center left:(NSArray *)left right:(NSArray *)right {
  return [self layoutWithCenter:center left:left right:right insets:UIEdgeInsetsZero spacing:0];
}

+ (instancetype)layoutWithCenter:(id)center left:(NSArray *)left right:(NSArray *)right insets:(UIEdgeInsets)insets spacing:(CGFloat)spacing {
  YOHBorderLayout *borderLayout = [[self.class alloc] init];
  borderLayout.center = center;
  borderLayout.left = [left mutableCopy];
  borderLayout.right = [right mutableCopy];
  borderLayout.insets = insets;
  borderLayout.spacing = spacing;
  return borderLayout;
}

@end

