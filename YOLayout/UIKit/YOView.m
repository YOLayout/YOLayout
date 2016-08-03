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

- (void)viewInit {
  // Don't add anything here, in case subclasses forget to call super
}

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    [self viewInit];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  if ((self = [super initWithCoder:aDecoder])) {
    [self viewInit];
  }
  return self;
}

- (void)setFrame:(CGRect)frame {
  if (_layout && !YOCGSizeIsEqual(self.frame.size, frame.size)) [_layout setNeedsLayout];
  [super setFrame:frame];
}

- (void)addSubview:(UIView *)subview {
  NSAssert([subview superview] != self, @"View is already added to this view");
  NSAssert(![subview superview], @"View already has a superview. You should call removeFromSuperview first.");
  [super addSubview:subview];
}

#pragma mark Layout

- (void)layoutSubviews {
  [super layoutSubviews];
  if (_layout) {
    [_layout layoutSubviews:self.frame.size];
  }
}

- (CGSize)sizeThatFits:(CGSize)size {
  if (_layout) {
    return [_layout sizeThatFits:size];
  }
  return [super sizeThatFits:size];
}

- (void)setNeedsLayout {
  [super setNeedsLayout];
  [self setNeedsDisplay];
  [_layout setNeedsLayout];
}

- (void)layoutView {
  NSAssert(_layout, @"Missing layout instance");
  [_layout setNeedsLayout];
  [_layout layoutSubviews:self.frame.size];
}

@end
