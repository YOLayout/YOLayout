//
//  YONSTestView.m
//  YOLayoutExample
//
//  Created by Gabriel on 1/20/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "YONSTestView.h"

#import "YOLabel.h"
#import "YONSButton.h"

@interface YONSTestView ()
@property YOLabel *label1;
@property YONSButton *button1;
@property YOLabel *label2;
@property YOLabel *label3;
@end

@implementation YONSTestView

- (void)viewInit {
  [super viewInit];

  _label1 = [[YOLabel alloc] init];
  [_label1 setText:@"Text (sizeToFitVerticalInFrame): Single-origin coffee quinoa pickled, 90's street art tilde Truffaut Shoreditch butcher sustainable +1 tousled church-key. " font:[NSFont systemFontOfSize:16] color:[NSColor blackColor] alignment:NSCenterTextAlignment];
  [self addSubview:_label1];

  _button1 = [YONSButton buttonWithText:@"Button (centerwithSize)"];
  self.button1.targetBlock = ^{ };
  [self addSubview:_button1];

  _label2 = [[YOLabel alloc] init];
  [_label2 setText:@"Text (centerwithSize, unknown height) Seitan umami Brooklyn cold-pressed street art, forage heirloom. PBR&B typewriter salvia" font:[NSFont systemFontOfSize:16] color:[NSColor blackColor] alignment:NSCenterTextAlignment];
  [self addSubview:_label2];

  _label3 = [[YOLabel alloc] init];
  [_label3 setText:@"Text (right/bottom align) Seitan umami Brooklyn cold-pressed street art, forage heirloom. PBR&B typewriter salvia" font:[NSFont systemFontOfSize:16] color:[NSColor blackColor] alignment:NSRightTextAlignment];
  [self addSubview:_label3];

  YOSelf yself = self;
  self.viewLayout = [YOLayout layoutWithLayoutBlock:^(id<YOLayout> layout, CGSize size) {
    CGFloat x = 20;
    CGFloat y = 60;

    // Size to fit vertically
    y += [layout sizeToFitVerticalInFrame:CGRectMake(x, y, size.width - 40, 0) view:yself.label1].size.height + 20;

    // Center vertically
    y += [layout centerWithSize:CGSizeMake(300, 44) frame:CGRectMake(x, y, size.width - 40, 44) view:yself.button1].size.height + 20;

    // Center with unknown height
    y += [layout centerWithSize:CGSizeMake(400, 0) frame:CGRectMake(x, y, size.width - 40, 0) view:yself.label2].size.height + 20;

    // Align right bottom size to fit
    y += [layout setSize:CGSizeMake(200, 0) inRect:CGRectMake(x, y, size.width - 40, 0) view:yself.label3 options:YOLayoutOptionsSizeToFit|YOLayoutOptionsAlignRight|YOLayoutOptionsAlignBottom].size.height + 20;

    return CGSizeMake(size.width, y);
  }];
}

@end
