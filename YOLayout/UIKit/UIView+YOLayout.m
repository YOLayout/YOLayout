//
//  UIView+YOLayout.m
//  YOLayoutExample
//
//  Created by Lucas Yan on 8/1/16.
//  Copyright © 2016 YOLayout. All rights reserved.
//

#import "UIView+YOLayout.h"
#import <objc/runtime.h>
#import "YOLayout.h"
#import "YOCGUtils.h"
#import "YOLayout+Internal.h"

static char kUIViewAssociatedLayoutKey;

@implementation UIView (YOLayout)

#pragma mark Swizzling

+ (void)useYOLayout {
  [self yo_exchangeImplementation:@selector(initWithFrame:) withImplementation:@selector(_initWithFrame:)];
  [self yo_exchangeImplementation:@selector(initWithCoder:) withImplementation:@selector(_initWithCoder:)];
  [self yo_exchangeImplementation:@selector(setFrame:) withImplementation:@selector(yo_setFrame:)];
  [self yo_exchangeImplementation:@selector(layoutSubviews) withImplementation:@selector(yo_layoutSubviews)];
  [self yo_exchangeImplementation:@selector(sizeThatFits:) withImplementation:@selector(yo_sizeThatFits:)];
  [self yo_exchangeImplementation:@selector(setNeedsLayout) withImplementation:@selector(yo_setNeedsLayout)];
}

+ (void)yo_exchangeImplementation:(SEL)originalImplementation withImplementation:(SEL)replacementImplementation {
  Method originalMethod = class_getInstanceMethod(self, originalImplementation);
  Method swizzledMethod = class_getInstanceMethod(self, replacementImplementation);

  BOOL didAddMethod = class_addMethod(self, originalImplementation, method_getImplementation(swizzledMethod),method_getTypeEncoding(swizzledMethod));

  if (didAddMethod) {
    class_replaceMethod(self, replacementImplementation, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
  } else {
    method_exchangeImplementations(originalMethod, swizzledMethod);
  }
}

#pragma mark Associated Getter/Setter

- (void)setLayout:(YOLayout *)layout {
  objc_setAssociatedObject(self, &kUIViewAssociatedLayoutKey, layout, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (YOLayout *)layout {
  return objc_getAssociatedObject(self, &kUIViewAssociatedLayoutKey);
}

#pragma mark Shared Initializer

- (void)viewInit {
  // Don't add anything here, in case subclasses forget to call super
}

- (id)_initWithFrame:(CGRect)frame {
  self = [self _initWithFrame:frame];
  if (self) {
    [self viewInit];
  }
  return self;
}

- (id)_initWithCoder:(NSCoder *)aDecoder {
  self = [self _initWithCoder:aDecoder];
  if (self) {
    [self viewInit];
  }
  return self;
}

#pragma mark Layout

- (void)yo_setFrame:(CGRect)frame {
  if (self.layout && !YOCGSizeIsEqual(self.frame.size, frame.size)) {
    [self.layout setNeedsLayout];
  }
  [self yo_setFrame:frame];
}

- (void)yo_layoutSubviews {
  [self yo_layoutSubviews];
  [self.layout layoutSubviews:self.frame.size];
}

- (CGSize)yo_sizeThatFits:(CGSize)size {
  if (self.layout) {
    return [self.layout sizeThatFits:size];
  }
  return [self yo_sizeThatFits:size];
}

- (void)yo_setNeedsLayout {
  [self yo_setNeedsLayout];
  [self.layout setNeedsLayout];
}

- (void)layoutView {
  NSAssert(self.layout, @"Missing layout instance");
  [self.layout setNeedsLayout];
  [self.layout layoutSubviews:self.frame.size];
}

@end
