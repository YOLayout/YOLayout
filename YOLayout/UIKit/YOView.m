//
//  YOView.m
//  YOLayout
//
//  Created by Gabriel Handford on 10/29/13.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

#import "YOView.h"
#import "YOCGUtils.h"
#import "YOLayout+Internal.h"

@implementation YOView

#pragma mark Shared Initializer

- (void)viewInit {
  // Don't add anything here, in case subclasses forget to call super
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self viewInit];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self viewInit];
  }
  return self;
}

#pragma mark Layout

- (void)setFrame:(CGRect)frame {
  if (_layout && !YOCGSizeIsEqual(self.frame.size, frame.size)) {
    [_layout setNeedsLayout];
  }
  [super setFrame:frame];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  [_layout layoutSubviews:self.frame.size];
}

- (CGSize)sizeThatFits:(CGSize)size {
  if (_layout) {
    return [_layout sizeThatFits:size];
  }
  return [super sizeThatFits:size];
}

- (void)setNeedsLayout {
  [super setNeedsLayout];
  [_layout setNeedsLayout];
}

- (void)layoutView {
  NSAssert(_layout, @"Missing layout instance");
  [_layout setNeedsLayout];
  [_layout layoutSubviews:self.frame.size];
}

@end
