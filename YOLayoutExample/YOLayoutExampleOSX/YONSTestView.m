//
//  YONSTestView.m
//  YOLayoutExample
//
//  Created by Gabriel on 1/20/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "YONSTestView.h"

#import "YONSLabel.h"
#import "YONSButton.h"

@interface YONSTestView ()
@property YONSLabel *label;
@property YONSButton *button;
@end

@implementation YONSTestView

- (void)viewInit {
  [super viewInit];

  _label = [[YONSLabel alloc] init];
  [_label setText:@"This is a label!" font:[NSFont systemFontOfSize:16] color:[NSColor blackColor] alignment:NSCenterTextAlignment];
  [self addSubview:_label];

  _button = [YONSButton buttonWithText:@"Button"];
  self.button.targetBlock = ^{ };
  [self addSubview:_button];

  YOSelf yself = self;
  self.viewLayout = [YOLayout layoutWithLayoutBlock:^(id<YOLayout> layout, CGSize size) {
    CGFloat x = 20;
    CGFloat y = 20;

    y += [layout sizeToFitVerticalInFrame:CGRectMake(x, y, size.width - 40, 0) view:yself.label].size.height + 20;

    y += [layout centerWithSize:CGSizeMake(160, 44) frame:CGRectMake(x, y, size.width - 40, 44) view:yself.button].size.height + 20;

    return CGSizeMake(size.width, y);
  }];
}

@end
