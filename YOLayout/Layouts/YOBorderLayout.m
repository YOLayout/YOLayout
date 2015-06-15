//
//  YOBorderLayout.m
//  YOLayoutExample
//
//  Created by Gabriel on 4/24/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "YOBorderLayout.h"

@interface YOBorderLayout ()
@property NSMutableArray *top;
@property NSMutableArray *bottom;
@end

@implementation YOBorderLayout

- (instancetype)init {
  if ((self = [super init])) {
    YOSelf yself = self;
    self.layoutBlock = ^(id<YOLayout> layout, CGSize size) {
      UIEdgeInsets insets = yself.insets;
      CGFloat spacing = yself.spacing;
      CGSize sizeInset = CGSizeMake(size.width - insets.left - insets.right, size.height - insets.top - insets.bottom);

      CGSize topSizeAll = CGSizeZero;
      for (id topView in yself.top) {
        CGSize topSize = [topView sizeThatFits:CGSizeMake(sizeInset.width, 0)];
        topSizeAll.height += topSize.height;
        topSizeAll.width = MAX(topSizeAll.width, topSize.width);
      }
      CGSize bottomSizeAll = CGSizeZero;
      for (id bottomView in yself.bottom) {
        CGSize bottomSize = [bottomView sizeThatFits:CGSizeMake(sizeInset.width, 0)];
        bottomSizeAll.height += bottomSize.height;
        bottomSizeAll.width = MAX(bottomSizeAll.width, bottomSize.width);
      }

      CGFloat centerHeight = sizeInset.height - topSizeAll.height - bottomSizeAll.height;
      if ([yself.top count] > 0) centerHeight -= yself.spacing * [yself.top count];
      if ([yself.bottom count] > 0) centerHeight -= yself.spacing * [yself.bottom count];

      CGFloat y = insets.top;
      for (id topView in yself.top) {
        y += [layout sizeToFitVerticalInFrame:CGRectMake(insets.left, y, size.width - insets.left - insets.right, 0) view:topView].size.height + spacing;
      }

      if (yself.center) {
        y += [layout setFrame:CGRectMake(insets.left, y, sizeInset.width, centerHeight) view:yself.center].size.height + spacing;
      } else {
        y += centerHeight;
      }

      for (id bottomView in yself.bottom) {
        y += [layout sizeToFitVerticalInFrame:CGRectMake(insets.left, y, size.width - insets.left - insets.right, 0) view:bottomView].size.height + spacing;
      }

      if (yself.maxSize.width > 0) size.width = MIN(size.width, yself.maxSize.width);
      if (yself.maxSize.height > 0) size.height = MIN(size.height, yself.maxSize.height);
      
      return size;
    };

  }
  return self;
}

+ (instancetype)layout {
  return [[self.class alloc] init];
}

+ (instancetype)layoutWithCenter:(id)center top:(NSArray *)top bottom:(NSArray *)bottom {
  return [self layoutWithCenter:center top:top bottom:bottom insets:UIEdgeInsetsZero spacing:0];
}

+ (instancetype)layoutWithCenter:(id)center top:(NSArray *)top bottom:(NSArray *)bottom insets:(UIEdgeInsets)insets spacing:(CGFloat)spacing {
  return [self layoutWithCenter:center top:top bottom:bottom insets:insets spacing:spacing maxSize:CGSizeZero];
}

+ (instancetype)layoutWithCenter:(id)center top:(NSArray *)top bottom:(NSArray *)bottom insets:(UIEdgeInsets)insets spacing:(CGFloat)spacing maxSize:(CGSize)maxSize {
  YOBorderLayout *borderLayout = [[self.class alloc] init];
  borderLayout.center = center;
  borderLayout.top = [top mutableCopy];
  borderLayout.bottom = [bottom mutableCopy];
  borderLayout.insets = insets;
  borderLayout.spacing = spacing;
  borderLayout.maxSize = maxSize;
  return borderLayout;
}

- (void)addToTop:(id)top {
  if (!_top) _top = [NSMutableArray array];
  [_top addObject:top];
  [self setNeedsLayout];
}

- (void)addToBottom:(id)bottom {
  if (!_bottom) _bottom = [NSMutableArray array];
  [_bottom addObject:bottom];
  [self setNeedsLayout];
}

@end
