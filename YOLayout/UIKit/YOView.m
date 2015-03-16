//
//  YOView.m
//  YOLayout
//
//  Created by Gabriel Handford on 10/29/13.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

#import "YOView.h"
#import "YOCGUtils.h"

@interface YOView ()
@property NSMutableArray *observeAttributes;
@end

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

- (void)dealloc {
  for (NSString *attr in _observeAttributes) {
    [self removeObserver:self forKeyPath:attr context:@"attributesNeedUpdate"];
  }
}

- (void)setAttributesNeedUpdate:(NSArray *)attributes {
  if (!_observeAttributes) _observeAttributes = [NSMutableArray array];
  [_observeAttributes addObjectsFromArray:attributes];
  for (NSString *attr in attributes) {
    [self addObserver:self forKeyPath:attr options:NSKeyValueObservingOptionNew context:@"attributesNeedUpdate"];
  }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  if ([_observeAttributes containsObject:keyPath]) {
    [self setNeedsDisplay];
    [self setNeedsLayout];
  }
}

- (void)setFrame:(CGRect)frame {
  if (_viewLayout && !YOCGSizeIsEqual(self.frame.size, frame.size)) [_viewLayout setNeedsLayout];
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
  if (_viewLayout) {
    [_viewLayout layoutSubviews:self.frame.size];
  }
}

- (CGSize)sizeThatFits:(CGSize)size {
  if (_viewLayout) {
    return [_viewLayout sizeThatFits:size];
  }
  return [super sizeThatFits:size];
}

- (void)setNeedsLayout {
  [super setNeedsLayout];
  [self setNeedsDisplay];
  [_viewLayout setNeedsLayout];
}

#pragma mark Layout

- (void)layoutView {
  NSAssert(_viewLayout, @"Missing layout instance");
  [_viewLayout setNeedsLayout];
  [_viewLayout layoutSubviews:self.frame.size];
}

#pragma Deprecated

- (void)setLayout:(YOLayout *)layout {
  self.viewLayout = layout;
}

- (YOLayout *)layout {
  return self.viewLayout;
}

@end
