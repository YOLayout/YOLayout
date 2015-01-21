//
//  YONSButton.m
//  YOLayoutExample
//
//  Created by Gabriel on 1/20/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "YONSButton.h"

@implementation YONSButton

- (instancetype)initWithFrame:(NSRect)frame {
  if ((self = [super initWithFrame:frame])) {
    self.bezelStyle = NSRoundedBezelStyle;
    self.font = [NSFont systemFontOfSize:20];
  }
  return self;
}

+ (instancetype)buttonWithText:(NSString *)text {
  YONSButton *button = [[YONSButton alloc] init];
  [button setText:text font:[NSFont systemFontOfSize:20] color:[NSColor blackColor] alignment:NSCenterTextAlignment];
  return button;
}

+ (instancetype)buttonWithImage:(NSImage *)image {
  YONSButton *button = [[YONSButton alloc] init];
  button.image = image;
  button.bordered = NO;
  return button;
}

- (void)setText:(NSString *)text font:(NSFont *)font color:(NSColor *)color alignment:(NSTextAlignment)alignment {
  NSParameterAssert(font);
  NSParameterAssert(color);
  if (!text) text = @"";
  NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
  NSDictionary *attributes = @{NSForegroundColorAttributeName:color, NSFontAttributeName:font};
  [str setAttributes:attributes range:NSMakeRange(0, str.length)];

  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  paragraphStyle.alignment = alignment;
  [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
  [self setAttributedTitle:str];
}

- (void)setTargetBlock:(KBButtonTargetBlock)targetBlock {
  _targetBlock = targetBlock;
  self.target = self;
  self.action = @selector(_performTargetBlock);
}

- (void)_performTargetBlock {
  if (self.targetBlock) self.targetBlock();
}


@end
