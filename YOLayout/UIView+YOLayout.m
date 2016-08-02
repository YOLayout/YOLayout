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

static char kUIViewAssociatedLayoutKey;

@implementation UIView (YOLayout)

+ (void)useYOLayout {
  [self exchangeImplementation:@selector(initWithFrame:) withImplementation:@selector(_initWithFrame:)];
  [self exchangeImplementation:@selector(initWithCoder:) withImplementation:@selector(_initWithCoder:)];
  [self exchangeImplementation:@selector(setFrame:) withImplementation:@selector(_setFrame:)];
  [self exchangeImplementation:@selector(layoutSubviews) withImplementation:@selector(_layoutSubviews)];
  [self exchangeImplementation:@selector(sizeThatFits:) withImplementation:@selector(_sizeThatFits:)];
  [self exchangeImplementation:@selector(setNeedsLayout) withImplementation:@selector(_setNeedsLayout)];
}

+ (void)exchangeImplementation:(SEL)originalImplementation withImplementation:(SEL)replacementImplementation {
  Method originalMethod = class_getInstanceMethod(self, originalImplementation);
  Method swizzledMethod = class_getInstanceMethod(self, replacementImplementation);
  
  BOOL didAddMethod = class_addMethod(self, originalImplementation, method_getImplementation(swizzledMethod),method_getTypeEncoding(swizzledMethod));
  
  if (didAddMethod) {
    class_replaceMethod(self, replacementImplementation, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
  } else {
    method_exchangeImplementations(originalMethod, swizzledMethod);
  }
}

- (void)viewInit {
  
}

- (void)layoutView {
  [self.layout setNeedsLayout];
  [self.layout layoutSubviews:self.frame.size];
}

#pragma mark Overriden Methods

- (id)_initWithFrame:(CGRect)frame {
  if ((self = [self _initWithFrame:frame])) {
    [self viewInit];
  }
  return self;
}

- (id)_initWithCoder:(NSCoder *)aDecoder {
  if ((self = [self _initWithCoder:aDecoder])) {
    [self viewInit];
  }
  return self;
}

- (void)_setFrame:(CGRect)frame {
  if (!YOCGSizeIsEqual(self.frame.size, frame.size)) [self.layout setNeedsLayout];
  [self _setFrame:frame];
}

- (void)_setNeedsLayout {
  [self.layout setNeedsLayout];
  [self.layout layoutSubviews:self.frame.size];
}

#pragma mark Layout

- (void)_layoutSubviews {
  [self _layoutSubviews];
  [self.layout layoutSubviews:self.frame.size];
}

- (CGSize)_sizeThatFits:(CGSize)size {
  if (self.layout) {
    return [self.layout sizeThatFits:size];
  }
  return [self _sizeThatFits:size];
}

#pragma mark Getter/Setter

- (void)setLayout:(YOLayout *)layout {
  objc_setAssociatedObject(self, &kUIViewAssociatedLayoutKey, layout, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (YOLayout *)layout {
  return objc_getAssociatedObject(self, &kUIViewAssociatedLayoutKey);
}

@end
