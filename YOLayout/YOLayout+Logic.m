//
//  YOLayout+Logic.m
//  YOLayoutExample
//
//  Created by John Boiles on 7/28/16.
//  Copyright © 2016 YOLayout. All rights reserved.
//

#import "YOLayout+Logic.h"
#import "YOCGUtils.h"

@implementation YOLayout (Logic)

+ (CGRect)alignSize:(CGSize)size inRect:(CGRect)inRect options:(YOLayoutOptions)options {
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

  return CGRectMake(p.x, p.y, size.width, size.height);
}

+ (CGSize)sizeThatFits:(CGSize)size view:(id)view options:(YOLayoutOptions)options {
  CGSize originalSize = size;
  BOOL sizeToFit = ((options & YOLayoutOptionsSizeToFitHorizontal) != 0) || ((options & YOLayoutOptionsSizeToFitVertical) != 0);

  if (sizeToFit) {
    NSAssert([view respondsToSelector:@selector(sizeThatFits:)], @"sizeThatFits: must be implemented on %@ for use with YOLayoutOptionsSizeToFit", view);
    CGSize sizeThatFits = [view sizeThatFits:size];

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

  return size;
}

+ (CGRect)frameForView:(id)view size:(CGSize)size inRect:(CGRect)inRect options:(YOLayoutOptions)options {
  size = [self sizeThatFits:size view:view options:options];

  // If we passed in 0 for inRect height or width, then lets set it to the frame height or width.
  // This usually happens if we are sizing to fit, and is needed to align below.
  if (inRect.size.width == 0) inRect.size.width = size.width;
  if (inRect.size.height == 0) inRect.size.height = size.height;

  return [self alignSize:size inRect:inRect options:options];
}

+ (CGRect)frameForView:(id)view inRect:(CGRect)inRect options:(YOLayoutOptions)options {
  return [self frameForView:view size:inRect.size inRect:inRect options:options];
}

@end
