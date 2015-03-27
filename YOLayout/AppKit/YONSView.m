//
//  YONSView.m
//  YOLayoutExample
//
//  Created by Gabriel on 1/8/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "YONSView.h"
#import "YOCGUtils.h"

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

+ (instancetype)view {
  return [[YOView alloc] init];
}

- (BOOL)isFlipped {
  return YES;
}

- (void)setFrame:(CGRect)frame {
  if (_viewLayout && !YOCGRectIsEqual(self.frame, frame)) [_viewLayout setNeedsLayout];
  [super setFrame:frame];
}

- (void)addSubview:(NSView *)subview {
  NSAssert([subview superview] != self, @"View is already added to this view");
  NSAssert(![subview superview], @"View already has a superview");
  [super addSubview:subview];
}

#pragma mark Layout

- (void)layout {
  [super layout];
  if (_viewLayout) {
    [_viewLayout layoutSubviews:self.frame.size];
  }
}

- (void)sizeToFit {
  [self setFrameSize:[self sizeThatFits:self.frame.size]];
}

- (CGSize)sizeThatFits:(CGSize)size {
  if (!_viewLayout) return size;
  return [_viewLayout sizeThatFits:size];
}

- (void)layoutView {
  NSAssert(_viewLayout, @"Missing layout instance");
  [self setNeedsLayout:NO];
  [self layout];
}

- (void)setNeedsLayout:(BOOL)layout {
  [_viewLayout setNeedsLayout];
  [self invalidateIntrinsicContentSize];
  if (layout) {
    dispatch_async(dispatch_get_main_queue(), ^{
      [self layout];
    });
  }
}

- (void)setNeedsLayout {
  [self setNeedsLayout:YES];
}

@end
