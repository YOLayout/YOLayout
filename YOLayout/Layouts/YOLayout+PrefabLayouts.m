//
// Created by John Boiles on 7/28/16.
// Copyright (c) 2016 YOLayout. All rights reserved.
//

#import "YOLayout+PrefabLayouts.h"


@implementation YOLayout (PrefabLayouts)

+ (YOLayout *)fill:(id)subview {
  return [self layoutWithLayoutBlock:^CGSize(id<YOLayout> layout, CGSize size) {
      [layout setFrame:CGRectMake(0, 0, size.width, size.height) view:subview];
      return size;
  }];
}

+ (YOLayout *)center:(id)subview {
  return [self layoutWithLayoutBlock:^CGSize(id<YOLayout> layout, CGSize size) {
      CGSize sizeThatFits = [subview sizeThatFits:size];
      [layout centerWithSize:sizeThatFits frame:CGRectMake(0, 0, size.width, size.height) view:subview];
      return size;
  }];
}

+ (YOLayout *)fitVertical:(id)subview {
  return [self layoutWithLayoutBlock:^CGSize(id<YOLayout> layout, CGSize size) {
      CGFloat y = 0;
      y += [layout sizeToFitVerticalInFrame:CGRectMake(0, 0, size.width, size.height) view:subview].size.height;
      return CGSizeMake(size.width, y);
  }];
}

+ (YOLayout *)fitHorizontal:(id)subview {
  return [self layoutWithLayoutBlock:^CGSize(id<YOLayout> layout, CGSize size) {
      CGFloat x = 0;
      x += [layout sizeToFitHorizontalInFrame:CGRectMake(0, 0, size.width, size.height) view:subview].size.width;
      return CGSizeMake(x, size.height);
  }];
}

@end