//
//  YOLayout.h
//  YOLayout
//
//  Created by Gabriel Handford on 10/29/13.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#endif

@class YOLayout;

typedef NS_OPTIONS (NSUInteger, YOLayoutOptions) {
  YOLayoutOptionsNone = 0,
  // SIZING
  //! Size the view to fit vertically
  YOLayoutOptionsSizeToFitVertical = 1 << 0,
  //! Size the view to fit horizontally
  YOLayoutOptionsSizeToFitHorizontal = 1 << 1,
  //! Size the view to fit both horizontally and vertically
  YOLayoutOptionsSizeToFit = YOLayoutOptionsSizeToFitVertical | YOLayoutOptionsSizeToFitHorizontal,

  /*!
   Constrain sizeThatFit's width to the passed in frame.

   For example, UILabel sizeThatFits: may return a larger width than was specified, and this will constrain it.
   */
  YOLayoutOptionsConstrainWidth = 1 << 2,
  //! Constrain sizeThatFit's height to the passed in frame
  YOLayoutOptionsConstrainHeight = 1 << 3,
  //! Constrain sizeThatFit's height and width
  YOLayoutOptionsConstrainSize = YOLayoutOptionsConstrainWidth | YOLayoutOptionsConstrainHeight,

  /*!
   Constrain sizeThatFits to the size specified but maintain the original aspect ratio.

   This is useful for an image view that may need to be constrained to a max size, but still maintain its aspect ratio.
   */
  YOLayoutOptionsConstrainSizeMaintainAspectRatio = 1 << 4,

  //! Whether the height specified is the default. Using this option will use the specified height when sizeThatFits: returns a 0 height.
  YOLayoutOptionsDefaultHeight = 1 << 5,
  //! Whether the width specified is the default. Using this option will use the specified width when sizeThatFits: returns a 0 width.
  YOLayoutOptionsDefaultWidth = 1 << 6,
  /*!
   Whether the size specified is the default. Using this option will use the specified width and/or height when sizeThatFits: returns a 0 width and/or height, respectively.

   This is useful for an image view that has to load its data and may initially return 0 for sizeThatFits.
   */
  YOLayoutOptionsDefaultSize = YOLayoutOptionsDefaultHeight | YOLayoutOptionsDefaultWidth,

  // ALIGNMENT
  //! After sizing, center vertically in the passed in rect
  YOLayoutOptionsAlignCenterVertical = 1 << 10,
  //! After sizing, center horizontally in the passed in rect
  YOLayoutOptionsAlignCenterHorizontal = 1 << 11,
  //! After sizing, center vertically and horizontally in the passed in rect
  YOLayoutOptionsAlignCenter = YOLayoutOptionsAlignCenterVertical | YOLayoutOptionsAlignCenterHorizontal,
  //! After sizing, aligns the view with the right of the passed in rect
  YOLayoutOptionsAlignRight = 1 << 12,
  //! After sizing, aligns the view with the bottom of the passed in rect
  YOLayoutOptionsAlignBottom = 1 << 13,

  //! After sizing and positioning, potentially flip the x value for a RTL layout
  YOLayoutOptionsRTLIfNeeded = 1 << 14,
};


/*!
 Block containing logic to layout or size the current view, with the specified
 size as a hint. Return the size used.

 You should never setFrame on subviews in this block. Instead use the methods
 in layout in order to setFrame, and use what those methods return to layout other
 subviews. This is because setFrame calls are no-ops when the view is only sizing.

 This block must be implemented.

 @param layout Layout
 @param size Size to layout in
 @result size Size of the view being laid out
 */
typedef CGSize (^YOLayoutBlock)(YOLayout *layout, CGSize size);


/*!
 YOLayout is a way to size and layout views without having to implement layoutSubview and
 sizeToFit separately.
 
 It also provides a basic cache to avoid layout when the view is unchanged.
 
 YOLayout calculates a size that best fits the receiver’s subviews,
 without altering the subviews frames, or affecting layoutSubviews call hierarchy.
 
 Instead of defining both sizeThatFits: and layoutSubviews, you create a block named layoutBlock.
 In this block you use the layout instance to set the subview frames (if sizing).

 This prevents your code from altering subviews when you are sizing (for sizeThatFits:).
 
 For example,
 
 CGRect titleLabelFrame = [layout setFrame:CGRectMake(x, y, 400, 0) view:_titleLabel options:YOLayoutOptionsSizeToFit];
 // titleLabelFrame may have a different width and will have a valid height
 
 You can combine YOLayoutOptionsSizeToFit and YOLayoutOptionsCenter to have it be centered with a variable height.
 For example,
 
 CGRect titleLabelFrame = [layout setFrame:CGRectMake(x, y, 400, 0) view:_titleLabel options:YOLayoutOptionsSizeToFit|YOLayoutOptionsCenter];
 // titleLabelFrame may have a different width and will have a valid height and will have an x position so it is centered
 
 You can also combine YOLayoutOptionsSizeToFit with YOLayoutOptionsConstraintWidth
 to make sure the width isn't set larger than expected. For example,
 
 CGRect titleLabelFrame = [layout setFrame:CGRectMake(x, y, 400, 0) view:_titleLabel options:YOLayoutOptionsSizeToFit|YOLayoutOptionsConstraintWidth];
 // titleLabelFrame may have a different width but it won't be larger than 400
 
 You can combine YOLayoutOptionsSizeToFit, YOLayoutOptionsConstraintWidth, and YOLayoutOptionsDefaultWidth to make sure
 a view sizes to fit with max and default width (when 0).
 */
@interface YOLayout : NSObject

//! Whether the current layout instance is just sizing or setting frames
@property (readonly, getter=isSizing) BOOL sizing;

//! Block containing logic to layout or size the current view. See the discussion above the YOLayoutBlock typedef for more info.
@property (copy) YOLayoutBlock layoutBlock;

/*!
 Default layout.
 
 @param view View for layout (weak reference).
 @param layoutBlock Block containing layout code. See the discussion above the YOLayoutBlock typedef for more info.
 @result Layout
 */
+ (YOLayout *)layoutWithLayoutBlock:(YOLayoutBlock)layoutBlock;

#pragma mark - Layout methods

/*!
 Layout the subviews.
 
 @param size Size to layout in
 */
- (CGSize)layoutSubviews:(CGSize)size;

/*!
 Size that fits.
 
 @param size Size to layout in.
 @result The size needed to display the view
 */
- (CGSize)sizeThatFits:(CGSize)size;

/*!
 If layout is required. Otherwise cached value may be returned.
 This should be called when a views data changes.
 */
- (void)setNeedsLayout;

/*!
 For subclasses, in rare cases, if they need to know whether the layout will
 be applied or not via setFrame:view:
 
 @result YES if we are only sizing, NO if we are setting frames
 */
- (BOOL)isSizing;

/*!
 YOLayout can layout YOLayouts. To do this, YOLayout must, itself, be able to accept a frame.
 All subviews of the layout are offset by the frame's origin. Yo dawg I heard you like YOLayouts...
 
 @param frame Frame to layout in.
 */
- (void)setFrame:(CGRect)frame;

#pragma mark - Subview Layout Methods

/*!
 Set frame for the (sub)view.
 If we are only sizing, this doesn't modify views frame.
 
 @param frame Frame
 @param view View should conform to YOLView informal protocol.
 */
- (CGRect)setFrame:(CGRect)frame view:(id)view;

/*!
 Set the (sub)view frame.
 If we are only sizing, this doesn't modify views frame.
 
 @param frame Frame
 @param view View should conform to YOLView informal protocol.
 @param options Options for setFrame; See YOLayoutOptions for more info
 @result The view frame.
 */
- (CGRect)setFrame:(CGRect)frame view:(id)view options:(YOLayoutOptions)options;

/*!
 Set the size in rect with options.
 
 @param size Desired size (or size hint if using YOLayoutOptionsSizeToFit)
 @param inRect Rect in which to position the view. `inRect.size` may be different than `size` when using this method with YOLayoutOptionsAlignCenter, YOLayoutOptionsAlignCenterVertical, YOLayoutOptionsAlignRight, etc.
 @param view View
 @param options Options See YOLayoutOptions for more info
 @result The view frame.
 */
- (CGRect)setSize:(CGSize)size inRect:(CGRect)inRect view:(id)view options:(YOLayoutOptions)options;

@end
