//
//  YOBorderLayout.m
//  YOLayoutExample
//
//  Created by Gabriel on 4/24/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "YOBorderLayout.h"

@implementation YOBorderLayout

+ (instancetype)layoutWithCenter:(id)center top:(NSArray *)top bottom:(NSArray *)bottom insets:(UIEdgeInsets)insets spacing:(CGFloat)spacing {
  YOBorderLayout *borderLayout = [[self.class alloc] init];
  __weak YOBorderLayout *yself = borderLayout;
  borderLayout.layoutBlock = ^(id<YOLayout> layout, CGSize size) {

    CGSize sizeInset = CGSizeMake(size.width - insets.left - insets.right, size.height - insets.top - insets.bottom);

    CGSize topSizeAll = CGSizeZero;
    for (id topView in top) {
      CGSize topSize = [topView sizeThatFits:CGSizeMake(sizeInset.width, 0)];
      topSizeAll.height += topSize.height;
      topSizeAll.width = MAX(topSizeAll.width, topSize.width);
    }
    CGSize bottomSizeAll = CGSizeZero;
    for (id bottomView in bottom) {
      CGSize bottomSize = [bottomView sizeThatFits:CGSizeMake(sizeInset.width, 0)];
      bottomSizeAll.height += bottomSize.height;
      bottomSizeAll.width = MAX(bottomSizeAll.width, bottomSize.width);
    }

    CGFloat centerHeight = sizeInset.height - topSizeAll.height - bottomSizeAll.height;
    if ([top count] > 0) centerHeight -= spacing * [top count];
    if ([bottom count] > 0) centerHeight -= spacing * [bottom count];

    CGFloat y = insets.top;
    for (id topView in top) {
      y += [layout sizeToFitVerticalInFrame:CGRectMake(insets.left, y, size.width - insets.left - insets.right, 0) view:topView].size.height + spacing;
    }

    y += [layout setFrame:CGRectMake(insets.left, y, sizeInset.width, centerHeight) view:center].size.height + spacing;

    for (id bottomView in bottom) {
      y += [layout sizeToFitVerticalInFrame:CGRectMake(insets.left, y, size.width - insets.left - insets.right, 0) view:bottomView].size.height + spacing;
    }

    if (yself.maxSize.width > 0) size.width = MIN(size.width, yself.maxSize.width);
    if (yself.maxSize.height > 0) size.height = MIN(size.height, yself.maxSize.height);

    return size;
  };
  return borderLayout;
}

@end
