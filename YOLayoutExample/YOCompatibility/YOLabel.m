//
//  YOLabel.m
//  YOLayoutExample
//
//  Created by Gabriel on 2/12/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "YOLabel.h"

@interface YOLabel ()
@property UILabel *label;
@end

@implementation YOLabel

- (void)viewInit {
  [super viewInit];

  _label = [[UILabel alloc] init];
  _label.numberOfLines = 0;
  [self addSubview:_label];

  self.layout = [YOLayout fill:_label];
}

- (void)setText:(NSString *)text font:(YOFont *)font color:(YOColor *)color alignment:(YOTextAlignment)alignment {
  _label.text = text;
  _label.font = font;
  _label.textColor = color;
  _label.textAlignment = alignment;
  [_label setNeedsLayout];
}

@end
