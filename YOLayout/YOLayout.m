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
#if TARGET_OS_IPHONE
    BOOL RTL = [UIApplication sharedApplication].userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft;
#else
    BOOL RTL = [NSApplication sharedApplication].userInterfaceLayoutDirection == NSUserInterfaceLayoutDirectionRightToLeft;
#endif
    if (((options & YOLayoutOptionsFlipIfNeededForRTL) != 0) && RTL) {
      // Flip for RTL using this layout's size as the parent
      // QQ: Does this handle all the cases we need it to?
      CGFloat x = _cachedSize.width - (frame.origin.x + frame.size.width);
      frameToSet.origin.x = x;
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

@end
