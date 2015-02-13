//
//  CompatibilityTestView.m
//  YOLayoutExample
//
//  Created by Gabriel on 2/12/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "CompatibilityTestView.h"

#import "YOLabel.h"

@interface CompatibilityTestView ()
@end

@implementation CompatibilityTestView

- (void)viewInit {
  [super viewInit];

  //self.backgroundColor = [YOColor whiteColor];

  YOLabel *label = [[YOLabel alloc] init];
   [label setText:@"This label will layout and render on both iOS and OSX!" font:(YOFont *)[YOFont systemFontOfSize:16] color:(YOColor *)[YOColor colorWithWhite:0.3 alpha:1.0] alignment:YOTextAlignmentCenter];
  [self addSubview:label];

  self.viewLayout = [YOLayout layoutWithLayoutBlock:^CGSize(id<YOLayout> layout, CGSize size) {
    CGFloat y = 100;
    y += [layout sizeToFitVerticalInFrame:CGRectMake(20, y, size.width - 40, 0) view:label].size.height;
    return CGSizeMake(size.width, y);
  }];
}

@end
