//
//  YONSView.h
//  YOLayoutExample
//
//  Created by Gabriel on 1/8/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import <AppKit/AppKit.h>

#import "YOLayout.h"

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
@interface YONSView : NSView { }

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
 Set needs layout.
 */
- (void)setNeedsLayout;

@end
