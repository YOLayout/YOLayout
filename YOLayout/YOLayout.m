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
@property (weak) UIView *view;
@end

@implementation YOLayout

- (id)init {
  [NSException raise:NSDestinationInvalidException format:@"Layout must be associated with a view; Use initWithLayoutBlock:"];
  return nil;
}

- (id)initWithView:(UIView *)view layoutBlock:(YOLayoutBlock)layoutBlock {
  NSParameterAssert(layoutBlock);

  if ((self = [super init])) {
    _view = view;
    _layoutBlock = layoutBlock;
    _needsLayout = YES;
    _needsSizing = YES;
  }
  return self;
}

+ (YOLayout *)layoutWithView:(UIView *)view layoutBlock:(YOLayoutBlock)layoutBlock {
  return [[YOLayout alloc] initWithView:view layoutBlock:layoutBlock];
}

- (CGSize)_layout:(CGSize)size sizing:(BOOL)sizing {
  if (YOCGSizeIsEqual(size, _cachedSize) && ((!_needsSizing && sizing) || (!_needsLayout && !sizing))) {
    return _cachedLayoutSize;
  }

  _sizing = sizing;
  _cachedSize = size;
  CGSize layoutSize = self.layoutBlock(self, _view, size);
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
  return [self setFrame:frame view:view options:(sizeToFit ? YOLayoutOptionsSizeToFit : 0)];
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
  BOOL sizeToFit = ((options & YOLayoutOptionsSizeToFitHorizontal) == YOLayoutOptionsSizeToFitHorizontal)
  || ((options & YOLayoutOptionsSizeToFitVertical) == YOLayoutOptionsSizeToFitVertical)
  || ((options & YOLayoutOptionsSizeToFitConstrainSizeMaintainAspectRatio) == YOLayoutOptionsSizeToFitConstrainSizeMaintainAspectRatio);

  CGSize sizeThatFits = CGSizeZero;
  if (sizeToFit) {
    sizeThatFits = [view sizeThatFits:frame.size];
    
    // If size that fits returns a larger width, then we'll need to constrain it.
    if (((options & YOLayoutOptionsSizeToFitConstrainWidth) == YOLayoutOptionsSizeToFitConstrainWidth) && sizeThatFits.width > frame.size.width) {
      sizeThatFits.width = frame.size.width;
    }

    // If size that fits returns a larger height, then we'll need to constrain it.
    if (((options & YOLayoutOptionsSizeToFitConstrainHeight) == YOLayoutOptionsSizeToFitConstrainHeight) && sizeThatFits.height > frame.size.height) {
      sizeThatFits.height = frame.size.height;
    }

    // If size that fits returns a larger width or height, constrain it, but also maintain the aspect ratio from sizeThatFits
    if (((options & YOLayoutOptionsSizeToFitConstrainSizeMaintainAspectRatio) == YOLayoutOptionsSizeToFitConstrainSizeMaintainAspectRatio) && (sizeThatFits.height > frame.size.height || sizeThatFits.width > frame.size.width)) {
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

    if (sizeThatFits.width == 0 && ((options & YOLayoutOptionsSizeToFitDefaultSize) == YOLayoutOptionsSizeToFitDefaultSize)) {
      sizeThatFits.width = frame.size.width;
    }
    
    if (sizeThatFits.height == 0 && ((options & YOLayoutOptionsSizeToFitDefaultSize) == YOLayoutOptionsSizeToFitDefaultSize)) {
      sizeThatFits.height = frame.size.height;
    }

    frame.size = sizeThatFits;
  }
  
  if ((options & YOLayoutOptionsSizeToFitHorizontal) != YOLayoutOptionsSizeToFitHorizontal) {
    frame.size.width = originalFrame.size.width;
  }
  
  if ((options & YOLayoutOptionsSizeToFitVertical) != YOLayoutOptionsSizeToFitVertical) {
    frame.size.height = originalFrame.size.height;
  }
  
  CGRect rect = originalFrame;
  if (!CGRectIsEmpty(inRect)) rect = inRect;
  
  if ((options & YOLayoutOptionsAlignCenterVertical) == YOLayoutOptionsAlignCenterVertical) {
    frame = YOCGRectToCenterYInRect(frame, originalFrame);
  }

  if ((options & YOLayoutOptionsAlignCenterHorizontal) == YOLayoutOptionsAlignCenterHorizontal) {
    frame = YOCGRectToCenterXInRect(frame, originalFrame);
  }

  if ((options & YOLayoutOptionsAlignRight) == YOLayoutOptionsAlignRight) {
    frame = YOCGRectRightAlignWithRect(frame, rect);
  }

  if ((options & YOLayoutOptionsAlignBottom) == YOLayoutOptionsAlignBottom) {
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

