//
//  YOLayout.h
//  YOLayout
//
//  Created by Gabriel Handford on 10/29/13.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

#define YOWeakObject(o) __typeof__(o) __weak
#define YOSelf YOWeakObject(self)

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#endif

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
};


@protocol YOLayout <NSObject>

/*!
 Calculate a (sub)view's frame.

 @param view View object should implement sizeThatFits:
 @param containerFrame Default frame to set for the view
 @param options Options for setFrame; See YOLayoutOptions for more info
 @result The calculated frame.
 */
+ (CGRect)frameForView:(id)view containerFrame:(CGRect)containerFrame options:(YOLayoutOptions)options;

/*!
 Calculate a (sub)view's frame.

 @param view View object should implement sizeThatFits:
 @param size Desired size (or size hint if using YOLayoutOptionsSizeToFit)
 @param containerFrame Rect in which to position the view. `inRect.size` may be different than `size` when using this method with YOLayoutOptionsAlignCenter, YOLayoutOptionsAlignCenterVertical, YOLayoutOptionsAlignRight, etc.
 @param options Options for setFrame; See YOLayoutOptions for more info
 @result The calculated frame.
 */
+ (CGRect)frameForView:(id)view size:(CGSize)size containerFrame:(CGRect)containerFrame options:(YOLayoutOptions)options;

/*!
 Layout the subviews.
 
 @param size Size to layout in
 */
- (CGSize)layoutSubviews:(CGSize)size;

/*!
 Size that fits.
 
 @param size Size to layout in; Should have a width specified.
 @result The size needed to display the view
 */
- (CGSize)sizeThatFits:(CGSize)size;

/*!
 Calculate size of a subview with options.
 */
- (CGSize)sizeThatFits:(CGSize)size view:(id)view options:(YOLayoutOptions)options;

/*!
 Set frame for the (sub)view.
 If we are only sizing, this doesn't modify views frame.
 
 @param frame Frame
 @param view View should conform to YOLView informal protocol.
 */
- (CGRect)setFrame:(CGRect)frame view:(id)view;

/*!
 Size to fit the view.
 If we are only sizing, this doesn't modify views frame.
 
 @param frame Frame
 @param view View should conform to YOLView informal protocol.
 @result The view frame.
 */
- (CGRect)sizeToFitInFrame:(CGRect)frame view:(id)view;

/*!
 Size to fit the view vertically.
 If we are only sizing, this doesn't modify views frame.

 @param frame Frame
 @param view View should conform to YOLView informal protocol.
 @result The view frame.
 */
- (CGRect)sizeToFitVerticalInFrame:(CGRect)frame view:(id)view;

/*!
 Size to fit the view horizontally.
 If we are only sizing, this doesn't modify views frame.

 @param frame Frame
 @param view View should conform to YOLView informal protocol.
 @result The view frame.
 */
- (CGRect)sizeToFitHorizontalInFrame:(CGRect)frame view:(id)view;

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
 Center view with size in frame.
 
 If the desired size.height == 0, then it will size to fit vertically using the specified width.
 If the desired size.width == 0, then it will size to fit horizontally using the specified height.
 
 @param size Desired size (or desired width and/or height)
 @param frame In frame
 @param view View
 @result The view frame.
 */
- (CGRect)centerWithSize:(CGSize)size frame:(CGRect)frame view:(id)view;

/*!
 Set the size in rect with options.
 
 @param size Desired size (or size hint if using YOLayoutOptionsSizeToFit)
 @param inRect Rect in which to position the view. `inRect.size` may be different than `size` when using this method with YOLayoutOptionsAlignCenter, YOLayoutOptionsAlignCenterVertical, YOLayoutOptionsAlignRight, etc.
 @param view View
 @param options Options See YOLayoutOptions for more info
 @result The view frame.
 */
- (CGRect)setSize:(CGSize)size inRect:(CGRect)inRect view:(id)view options:(YOLayoutOptions)options;

/*!
 Set origin. Same as setFrame:view: but uses the existing view.frame.size.

 @param origin Origin
 @param view View
 @param options Options
 */
- (CGRect)setOrigin:(CGPoint)origin view:(id)view options:(YOLayoutOptions)options;

/*!
 Set size. Same as setFrame:view: but uses the existing view.frame.origin.
 
 @param size Size
 @param view View
 @param options Options
 */
- (CGRect)setSize:(CGSize)size view:(id)view options:(YOLayoutOptions)options;

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

@end


/*
 UIViews can implement this protocol, to enable custom layouts.
 */
@protocol YOLayoutView <NSObject>

/*!
 Layout object belonging to the class implementing this protocol.
 */
@property id <YOLayout>layout;

@end


/*!
 UIViews can also use custom layouts even if they aren't in the view hierarchy (can't do that with Auto Layout!). This protocol presents a convention for how to create drawable views. To create a drawable view, simply create a YOView that implements drawInRect:. Then superviews can draw the view in their drawRect method.
 */
@protocol YODrawableView <YOLayoutView>

/*!
 @result Draw the drawable
 */
- (void)drawInRect:(CGRect)rect;

@end


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
typedef CGSize (^YOLayoutBlock)(id<YOLayout> layout, CGSize size);


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
@interface YOLayout : NSObject <YOLayout>

@property (readonly, getter=isSizing) BOOL sizing;
//! Block containing logic to layout or size the current view. See the discussion above the YOLayoutBlock typedef for more info.
@property (copy) YOLayoutBlock layoutBlock;

/*!
 Set a custon/fixed size that fits.
 Override the size that is returned by sizeThatFits:(CGSize)size.
 Defaults to CGSizeZero, which is unset.
 If height is not set (is 0), then we will use this size value for sizeThatFits:.
 */
@property CGSize sizeThatFits;

/*!
 Create layout.

 @param layoutBlock Block containing layout code. See the discussion above the YOLayoutBlock typedef for more info.
 */
- (id)initWithLayoutBlock:(YOLayoutBlock)layoutBlock;

/*!
 Default layout.

 @param view View for layout (weak reference).
 @param layoutBlock Block containing layout code. See the discussion above the YOLayoutBlock typedef for more info.
 @result Layout
 */
+ (YOLayout *)layoutWithLayoutBlock:(YOLayoutBlock)layoutBlock;

#pragma mark -

/*!
 A layout which makes the specified subview fill the full size.

 @param subview The subview to layout
 @param Layout
 */
+ (YOLayout *)fill:(id)subview;

/*!
 A layout which makes the specified subview centered.

 @param subview The subview to center
 @param Layout
 */
+ (YOLayout *)center:(id)subview;

/*!
 A layout which makes the specified subview size to fit vertically.

 @param subview The subview to layout
 @param Layout
 */
+ (YOLayout *)fitVertical:(id)subview;

/*!
 A layout which makes the specified subview size to fit horizontally.

 @param subview The subview to layout
 @param Layout
 */
+ (YOLayout *)fitHorizontal:(id)subview;

@end


#if !TARGET_OS_IPHONE

typedef struct UIEdgeInsets {
  CGFloat top, left, bottom, right;
} UIEdgeInsets;

extern const UIEdgeInsets UIEdgeInsetsZero;

static inline UIEdgeInsets UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
  UIEdgeInsets insets = {top, left, bottom, right};
  return insets;
}

static inline UIEdgeInsets UIEdgeInsetsAdd(UIEdgeInsets i1, UIEdgeInsets i2) {
  return UIEdgeInsetsMake(i1.top + i2.top, i1.left + i2.left, i1.bottom + i2.bottom, i1.right + i2.right);
}

#endif
