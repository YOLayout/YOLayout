//
//  YONSView.h
//  YOLayoutExample
//
//  Created by Gabriel on 1/8/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import <AppKit/AppKit.h>

#import "YOLayout_IMP.h"

/*!
 View with custom, programatic layout (via YOLayout).

 Instead of subclassing NSView, you can subclass YONSView and set the layout property.
 See YOLayout for more details.

 - (void)viewInit {
   [super viewInit];
   NSView *subview = [[NSView alloc] init];
   [self addSubview:subview];
   self.viewLayout = [YOLayout layoutWithLayoutBlock:^(id<YOLayout> layout, CGSize size) {
     [layout setFrame:CGRectMake(0, 0, size.width, 30) view:subview];
     return CGSizeMake(size.width, 30);
   }];
 }
 */
@interface YONSView : NSView

@property YOLayout *viewLayout;

/*!
 Subclasses can override this method to perform initialization tasks that occur during both initWithFrame: and initWithCoder:
 */
- (void)viewInit;

/*!
 Get size that fits.
 */
- (CGSize)sizeThatFits:(CGSize)size;

/*!
 Set size to size that fits current frame size.
 If the view is variable height (usually the case), this will set the re-set the height based on the current frame width.
 If the view is variable width, this will set the re-set the width based on the current frame height;
 */
- (void)sizeToFit;

/*!
 Set needs layout.
 */
- (void)setNeedsLayout;

/*!
 Force the layout, if using YOLayout.
 You can use this instead of setNeedsLayout + layoutIfNeeded.
 This is also useful when using animations and setNeedsLayout + layoutIfNeeded don't work as expected.
 */
- (void)layoutView;

//
// Helpers to make views a little more like UIKit
//

@property BOOL clipToBounds; // Writable alias for wantsDefaultClipping
@property NSInteger flag; // Instead of tag (writable)
@property (nonatomic) NSColor *backgroundColor;

@end
