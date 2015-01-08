//
//  YOLayout.m
//  YOLayout
//
//  Created by Gabriel Handford on 10/29/13.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

#import "YOLayout.h"
#import "YOCGUtils.h"

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

- (CGRect)setFrame:(CGRect)frame view:(id)view sizeToFit:(BOOL)sizeToFit {

  YOLayoutOptions options = 0;
  // If UILabel and 1 line, we need to fix size to fit options to constrain width,
  // since UILabel will return a size > the width we specify.
  if (sizeToFit && [view isKindOfClass:UILabel.class] && ((UILabel *)view).numberOfLines == 1) {
    options = YOLayoutOptionsSizeToFit | YOLayoutOptionsConstrainWidth;
  } else {
    options = YOLayoutOptionsSizeToFit;
  }

  return [self setFrame:frame view:view options:options];
}

- (CGRect)setFrame:(CGRect)frame view:(id)view options:(YOLayoutOptions)options {
  return [self setFrame:frame inRect:CGRectZero view:view options:options];
}

- (CGRect)setFrameInRect:(CGRect)inRect view:(id)view {
  CGSize sizeThatFits = [view sizeThatFits:CGSizeMake(inRect.size.width, inRect.size.height)];
  if (inRect.size.height == 0) inRect.size.height = sizeThatFits.height;
  return [self setFrame:CGRectMake(0, 0, sizeThatFits.width, sizeThatFits.height) inRect:inRect view:view options:YOLayoutOptionsAlignCenter];
}

- (CGRect)setFrame:(CGRect)frame inRect:(CGRect)inRect view:(id)view options:(YOLayoutOptions)options {

  CGRect originalFrame = frame;
  BOOL sizeToFit = ((options & YOLayoutOptionsSizeToFitHorizontal) != 0)
    || ((options & YOLayoutOptionsSizeToFitVertical) != 0);

  CGSize sizeThatFits = CGSizeZero;
  if (sizeToFit) {
    sizeThatFits = [view sizeThatFits:frame.size];
    
    // If size that fits returns a larger width, then we'll need to constrain it.
    if (((options & YOLayoutOptionsConstrainWidth) != 0) && sizeThatFits.width > frame.size.width) {
      sizeThatFits.width = frame.size.width;
    }

    // If size that fits returns a larger height, then we'll need to constrain it.
    if (((options & YOLayoutOptionsConstrainHeight) != 0) && sizeThatFits.height > frame.size.height) {
      sizeThatFits.height = frame.size.height;
    }

    // If size that fits returns a larger width or height, constrain it, but also maintain the aspect ratio from sizeThatFits
    if (((options & YOLayoutOptionsConstrainSizeMaintainAspectRatio) != 0) && (sizeThatFits.height > frame.size.height || sizeThatFits.width > frame.size.width)) {
      CGFloat aspectRatio = sizeThatFits.width / sizeThatFits.height;
      // If we're going to constrain by width
      if (sizeThatFits.width / frame.size.width > sizeThatFits.height / frame.size.height) {
        sizeThatFits.width = frame.size.width;
        sizeThatFits.height = roundf(frame.size.width / aspectRatio);
        // If we're going to constrain by height
      } else {
        sizeThatFits.height = frame.size.height;
        sizeThatFits.width = roundf(frame.size.height * aspectRatio);
      }
    }

    if (sizeThatFits.width == 0 && ((options & YOLayoutOptionsDefaultSize) != 0)) {
      sizeThatFits.width = frame.size.width;
    }
    
    if (sizeThatFits.height == 0 && ((options & YOLayoutOptionsDefaultSize) != 0)) {
      sizeThatFits.height = frame.size.height;
    }

    frame.size = sizeThatFits;
  }
  
  if ((options & YOLayoutOptionsSizeToFitHorizontal) == 0) {
    frame.size.width = originalFrame.size.width;
  }
  
  if ((options & YOLayoutOptionsSizeToFitVertical) == 0) {
    frame.size.height = originalFrame.size.height;
  }
  
  CGRect rect = originalFrame;
  if (!CGRectIsEmpty(inRect)) rect = inRect;
  
  if ((options & YOLayoutOptionsAlignCenterVertical) != 0) {
    frame = YOCGRectToCenterYInRect(frame, originalFrame);
  }

  if ((options & YOLayoutOptionsAlignCenterHorizontal) != 0) {
    frame = YOCGRectToCenterXInRect(frame, originalFrame);
  }

  if ((options & YOLayoutOptionsAlignRight) != 0) {
    frame = YOCGRectRightAlignWithRect(frame, rect);
  }

  if ((options & YOLayoutOptionsAlignBottom) != 0) {
    frame = YOCGRectBottomAlignWithRect(frame, rect);
  }

  [self setFrame:frame view:view];
  return frame;
}

- (CGRect)setX:(CGFloat)x frame:(CGRect)frame view:(id)view {
  frame.origin.x = x;
  return [self setFrame:frame view:view needsLayout:NO];
}

- (CGRect)setY:(CGFloat)y frame:(CGRect)frame view:(id)view {
  frame.origin.y = y;
  return [self setFrame:frame view:view needsLayout:NO];
}

- (CGRect)setOrigin:(CGPoint)origin view:(id)view {
  return [self setFrame:CGRectMake(origin.x, origin.y, [view frame].size.width, [view frame].size.height) view:view];
}

- (CGRect)setOrigin:(CGPoint)origin view:(id)view sizeToFit:(BOOL)sizeToFit {
  return [self setFrame:CGRectMake(origin.x, origin.y, [view frame].size.width, [view frame].size.height) view:view sizeToFit:sizeToFit];
}

- (CGRect)setSize:(CGSize)size view:(id)view {
  return [self setFrame:CGRectMake([view frame].origin.x, [view frame].origin.y, size.width, size.height) view:view];
}

- (CGRect)setSize:(CGSize)size view:(id)view sizeToFit:(BOOL)sizeToFit {
  return [self setFrame:CGRectMake([view frame].origin.x, [view frame].origin.y, size.width, size.height) view:view sizeToFit:sizeToFit];
}

- (CGRect)setY:(CGFloat)y view:(id)view {
  return [self setY:y frame:(view ? [view frame] : CGRectZero) view:view];
}

- (CGRect)setFrame:(CGRect)frame view:(id)view {
  return [self setFrame:frame view:view needsLayout:YES];
}

- (CGRect)setFrame:(CGRect)frame view:(id)view needsLayout:(BOOL)needsLayout {
  if (!view) return CGRectZero;
  if (!_sizing) {
    [view setFrame:frame];
    // Since we are applying the frame, the subview will need to
    // apply their layout next at this frame
    if (needsLayout) [view setNeedsLayout];
  }
  return frame;
}

@end

