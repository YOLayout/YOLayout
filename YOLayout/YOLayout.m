//
//  YOLayout.m
//  YOLayout
//
//  Created by Gabriel Handford on 10/29/13.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

#import "YOLayout.h"
#import "YOLayout+Logic.h"
#import "YOCGUtils.h"
#import <objc/runtime.h>

static char kYOLayoutAssociatedKeyIsRTLEnvironment;

@interface YOLayout ()

//! Block containing logic to layout or size the current view. See the discussion above the YOLayoutBlock typedef for more info.
@property (copy, nonnull) YOLayoutBlock layoutBlock;
@property BOOL needsLayout;
@property BOOL needsSizing;
@property CGSize cachedSize;
@property CGSize cachedLayoutSize;
@property (nonatomic) CGRect frame;

@end


@implementation YOLayout

#pragma mark - Lifecycle

+ (YOLayout *)layoutWithLayoutBlock:(YOLayoutBlock)layoutBlock {
  return [[YOLayout alloc] initWithLayoutBlock:layoutBlock];
}

- (id)init {
  if ((self = [super init])) {
    _needsLayout = YES;
    _needsSizing = YES;
  }
  return self;
}

- (id)initWithLayoutBlock:(YOLayoutBlock)layoutBlock {
  NSParameterAssert(layoutBlock);

  if ((self = [self init])) {
    _layoutBlock = layoutBlock;
  }
  return self;
}

#pragma mark - Layout internals

- (CGSize)_layout:(CGSize)size sizing:(BOOL)sizing {
  if (YOCGSizeIsEqual(size, _cachedSize) && ((!_needsSizing && sizing) || (!_needsLayout && !sizing))) {
    return _cachedLayoutSize;
  }

  _sizing = sizing;
  _cachedSize = size;
  CGSize layoutSize = self.layoutBlock(self, size);
  _cachedLayoutSize = layoutSize;
  if (!_sizing) {
    _needsLayout = NO;
  }
  _needsSizing = NO;
  _sizing = NO;
  return layoutSize;
}

- (void)setNeedsLayout {
  _needsLayout = YES;
  _needsSizing = YES;
  _cachedSize = CGSizeZero;
}

- (CGSize)layoutSubviews:(CGSize)size {
  return [self _layout:size sizing:NO];
}

- (CGSize)sizeThatFits:(CGSize)size {
  return [self _layout:size sizing:YES];
}

- (void)setFrame:(CGRect)frame {
  _frame = frame;

  [self _layout:frame.size sizing:NO];
}

#pragma mark - Subview layout methods

- (CGRect)setSize:(CGSize)size inRect:(CGRect)inRect view:(id)view options:(YOLayoutOptions)options {
  CGRect frame = [self.class frameForView:view size:size inRect:inRect options:options];

  if (!view) return CGRectZero;
  if (!_sizing) {

    CGRect frameToSet = frame;
    if ((options & YOLayoutOptionsFlipIfNeededForRTL) != 0) {

      // Determine if the current environment is right-to-left
      BOOL isRTL;
      NSNumber *isRTLEnvironmentNumber = [self.class isRTLEnvironmentNumber];
      if (isRTLEnvironmentNumber) {
        isRTL = isRTLEnvironmentNumber.boolValue;
      } else {
        // Try to determine right-to-left automatically
#if ONLY_EXTENSION_SAFE_APIS
        // iOS9 UIKit/UIView only
        // Note that this only works if you're using UIView. If you want to use RTL with a CALayer or other non-UIView class in an app extension, you'll need to setIsRTLEnvironment: in advance.
        // TODO: Use the similar `view.userInterfaceLayoutDirection` API for Mac/NSView
        if ([view isKindOfClass:[UIView class]] && [view respondsToSelector:@selector(semanticContentAttribute)]) {
          isRTL = [UIView userInterfaceLayoutDirectionForSemanticContentAttribute:((UIView *)view).semanticContentAttribute] == UIUserInterfaceLayoutDirectionRightToLeft;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_9_0 && DEBUG
          NSLog(@"WARNING: YOLayout is using iOS9-only APIs to determine whether layout should be RightToLeft, but your Deployment Target is < iOS9. You may want to use setIsRTLEnvironment: instead.");
#endif
        } else {
#if DEBUG
          NSLog(@"WARNING: YOLayout was unable to determine if the layout is in a right-to-left environment. You probably want to call setIsRTLEnvironment: in advance. Assuming left-to-right layout.");
#endif
        }
#else // !ONLY_EXTENSION_SAFE_APIS
#if TARGET_OS_IPHONE
        isRTL = [UIApplication sharedApplication].userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft;
#else
        isRTL = [NSApplication sharedApplication].userInterfaceLayoutDirection == NSUserInterfaceLayoutDirectionRightToLeft;
#endif
#endif // ONLY_EXTENSION_SAFE_APIS
      }

      if (isRTL) {
        // Flip for RTL using this layout's size as the parent
        CGFloat x = _cachedSize.width - (frame.origin.x + frame.size.width);
        frameToSet.origin.x = x;
      }
    }

    // If this layout object itself has a frame, offset the subview accordingly
    if (!YOCGRectIsEqual(self.frame, CGRectZero)) {
      frameToSet.origin.x += self.frame.origin.x;
      frameToSet.origin.y += self.frame.origin.y;
    }

    [view setFrame:frameToSet];

    // Since we are applying the frame, the subview will need to re-layout
    if ([view respondsToSelector:@selector(setNeedsLayout)]) {
      [view setNeedsLayout];
    }
  }

  return frame;
}

- (CGRect)setFrame:(CGRect)frame view:(id)view options:(YOLayoutOptions)options {
  return [self setSize:frame.size inRect:frame view:view options:options];
}

- (CGRect)setFrame:(CGRect)frame view:(id)view {
  return [self setFrame:frame view:view options:YOLayoutOptionsNone];
}

#pragma mark - Localization

+ (void)setIsRTLEnvironment:(BOOL)isRTLEnvironment {
  objc_setAssociatedObject(self, &kYOLayoutAssociatedKeyIsRTLEnvironment, @(isRTLEnvironment), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSNumber *)isRTLEnvironmentNumber {
  return objc_getAssociatedObject(self, &kYOLayoutAssociatedKeyIsRTLEnvironment);
}

@end
