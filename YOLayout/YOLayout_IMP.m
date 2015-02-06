//
//  YOLayout.m
//  YOLayout
//
//  Created by Gabriel Handford on 10/29/13.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

#import "YOLayout_IMP.h"
#import "YOCGUtils.h"

@protocol YOView <NSObject>
- (CGRect)frame;
- (void)setFrame:(CGRect)frame;
- (NSArray *)subviews;
@end

const UIEdgeInsets UIEdgeInsetsZero = {0, 0, 0, 0};

@interface YOLayout ()
@property BOOL needsLayout;
@property BOOL needsSizing;
@property CGSize cachedSize;
@property CGSize cachedLayoutSize;
@end

@implementation YOLayout

- (id)init {
  [NSException raise:NSDestinationInvalidException format:@"Layout must be associated with a view; Use initWithLayoutBlock:"];
  return nil;
}

- (id)initWithLayoutBlock:(YOLayoutBlock)layoutBlock {
  NSParameterAssert(layoutBlock);

  if ((self = [super init])) {
    _layoutBlock = layoutBlock;
    _needsLayout = YES;
    _needsSizing = YES;
  }
  return self;
}

+ (YOLayout *)layoutWithLayoutBlock:(YOLayoutBlock)layoutBlock {
  return [[YOLayout alloc] initWithLayoutBlock:layoutBlock];
}

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
  if (_sizeThatFits.width > 0 && _sizeThatFits.height > 0) return _sizeThatFits;
  if (_sizeThatFits.width > 0) size = _sizeThatFits;
  return [self _layout:size sizing:YES];
}

- (CGRect)sizeToFitVerticalInFrame:(CGRect)frame view:(id)view {
  return [self setFrame:frame view:view options:YOLayoutOptionsSizeToFitVertical];
}

- (CGRect)setFrame:(CGRect)frame view:(id)view options:(YOLayoutOptions)options {
  return [self setSize:frame.size inRect:frame view:view options:options];
}

- (CGRect)centerWithSize:(CGSize)size frame:(CGRect)frame view:(id)view {
  YOLayoutOptions options = YOLayoutOptionsAlignCenter;
  if (size.width == 0 || size.height == 0) options |= YOLayoutOptionsSizeToFit;
  return [self setSize:size inRect:frame view:view options:options];
}

- (CGRect)setSize:(CGSize)size inRect:(CGRect)inRect view:(id)view options:(YOLayoutOptions)options {

  CGSize originalSize = size;
  BOOL sizeToFit = ((options & YOLayoutOptionsSizeToFitHorizontal) != 0)
    || ((options & YOLayoutOptionsSizeToFitVertical) != 0);

  CGSize sizeThatFits = CGSizeZero;
  if (sizeToFit) {
    sizeThatFits = [view sizeThatFits:size];
    
    // If size that fits returns a larger width, then we'll need to constrain it.
    if (((options & YOLayoutOptionsConstrainWidth) != 0) && sizeThatFits.width > size.width) {
      sizeThatFits.width = size.width;
    }

    // If size that fits returns a larger height, then we'll need to constrain it.
    if (((options & YOLayoutOptionsConstrainHeight) != 0) && sizeThatFits.height > size.height) {
      sizeThatFits.height = size.height;
    }

    // If size that fits returns a larger width or height, constrain it, but also maintain the aspect ratio from sizeThatFits
    if (((options & YOLayoutOptionsConstrainSizeMaintainAspectRatio) != 0) && (sizeThatFits.height > size.height || sizeThatFits.width > size.width)) {
      CGFloat aspectRatio = sizeThatFits.width / sizeThatFits.height;
      // If we're going to constrain by width
      if (sizeThatFits.width / size.width > sizeThatFits.height / size.height) {
        sizeThatFits.width = size.width;
        sizeThatFits.height = roundf(size.width / aspectRatio);
        // If we're going to constrain by height
      } else {
        sizeThatFits.height = size.height;
        sizeThatFits.width = roundf(size.height * aspectRatio);
      }
    }

    if (sizeThatFits.width == 0 && ((options & YOLayoutOptionsDefaultWidth) != 0)) {
      sizeThatFits.width = size.width;
    }
    
    if (sizeThatFits.height == 0 && ((options & YOLayoutOptionsDefaultHeight) != 0)) {
      sizeThatFits.height = size.height;
    }

    size = sizeThatFits;
  }
  
  if ((options & YOLayoutOptionsSizeToFitHorizontal) == 0) {
    size.width = originalSize.width;
  }
  
  if ((options & YOLayoutOptionsSizeToFitVertical) == 0) {
    size.height = originalSize.height;
  }

  // If we passed in 0 for inRect height or width, then lets set it to the frame height or width.
  // This usually happens if we are sizing to fit, and is needed to align below.
  if (inRect.size.width == 0) inRect.size.width = size.width;
  if (inRect.size.height == 0) inRect.size.height = size.height;

  CGPoint p = inRect.origin;
  if ((options & YOLayoutOptionsAlignCenterHorizontal) != 0) {
    p.x += YOCGPointToCenterX(size, inRect.size).x;
  }

  if ((options & YOLayoutOptionsAlignCenterVertical) != 0) {
    p.y += YOCGPointToCenterY(size, inRect.size).y;
  }

  if ((options & YOLayoutOptionsAlignRight) != 0) {
    p.x = inRect.origin.x + inRect.size.width - size.width;
  }

  if ((options & YOLayoutOptionsAlignBottom) != 0) {
    p.y = inRect.origin.y + inRect.size.height - size.height;
  }

  CGRect frame = CGRectMake(p.x, p.y, size.width, size.height);
  [self setFrame:frame view:view];

  return frame;
}

- (CGRect)setOrigin:(CGPoint)origin view:(id)view options:(YOLayoutOptions)options {
  return [self setFrame:CGRectMake(origin.x, origin.y, [view frame].size.width, [view frame].size.height) view:view options:options];
}

- (CGRect)setSize:(CGSize)size view:(id)view options:(YOLayoutOptions)options {
  return [self setFrame:CGRectMake([view frame].origin.x, [view frame].origin.y, size.width, size.height) view:view options:options];
}

- (CGRect)setFrame:(CGRect)frame view:(id)view {
  if (!view) return CGRectZero;
  if (!_sizing) {
    [view setFrame:frame];
    // Since we are applying the frame, the subview will need to re-layout
    if ([view respondsToSelector:@selector(setNeedsLayout)]) [view setNeedsLayout]; // For UIKit (UIView)

    // Don't think we need this
    //if ([view respondsToSelector:@selector(setNeedsLayout:)]) [view setNeedsLayout:YES]; // For AppKit (NSView)
  }
  return frame;
}

#pragma mark Common Layouts

+ (YOLayout *)vertical:(NSArray *)subviews margin:(UIEdgeInsets)margin padding:(CGFloat)padding {
  return [self layoutWithLayoutBlock:[YOLayout verticalLayout:subviews margin:margin padding:padding]];
}

+ (YOLayoutBlock)verticalLayout:(NSArray *)subviews margin:(UIEdgeInsets)margin padding:(CGFloat)padding {
  return ^CGSize(id<YOLayout> layout, CGSize size) {
    CGFloat y = margin.top;
    NSInteger index = 0;
    for (id subview in subviews) {
      CGRect frame = [subview frame];
      y += [layout sizeToFitVerticalInFrame:CGRectMake(margin.left, y, size.width - margin.left - margin.right, frame.size.height) view:subview].size.height;
      if (++index != subviews.count) y += padding;
    }
    y += margin.bottom;
    return CGSizeMake(size.width, y);
  };
}

+ (YOLayout *)fill:(id)subview {
  return [self layoutWithLayoutBlock:[YOLayout fillLayout:subview]];
}

+ (YOLayoutBlock)fillLayout:(id)subview {
  return ^CGSize(id<YOLayout> layout, CGSize size) {
    [layout setFrame:CGRectMake(0, 0, size.width, size.height) view:subview];
    return size;
  };
}

@end

