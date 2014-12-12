//
//  YOView.h
//  YOLayout
//
//  Created by Gabriel Handford on 10/29/13.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

#import "YOLayout.h"

/*!
 View with custom, programatic layout (via YOLayout).
 
 Instead of subclassing UIView, you can subclass YOView and set the layout property.
 See YOLayout for more details.

      - (void)sharedInit {
         [super sharedInit];
         self.layout = [YOLayout layoutForView:self layoutBlock:^(id<YOLayout> layout, CGSize size) {
           [layout setFrame:CGRectMake(0, 0, size.width, 30)];
           return CGSizeMake(size.width, 30);
         }];
         self.backgroundColor = [UIColor whiteColor];
      }
 */
@interface YOView : UIView <YOLayoutView> { }

@property YOLayout *layout;

/*!
 Subclasses can override this method to perform initialization tasks that occur during both initWithFrame: and initWithCoder:
 */
- (void)sharedInit;

/*!
 Set the layout block for this view. A YOLayout object will be generated as well, if necessary
 Note: This is a method, not a parameter for easy autocompletion of the block type.
 */
- (void)setLayoutBlock:(YOLayoutBlock)layoutBlock;

/*!
 Set if needs refresh.
 If visible, will immediately trigger refresh. Otherwise will call refresh when becoming visible.
 */
@property BOOL needsRefresh;

/*!
 Force the layout, if using YOLayout.
 You can use this instead of setNeedsLayout + layoutIfNeeded.
 This is also useful when using animations and setNeedsLayout + layoutIfNeeded don't work as expected.
 */
- (void)layoutView;

/*!
 Calls needsLayoutBlock, in the case where you want to make the superview trigger an layout update.
 @param animated YES if the layout should animate
 */
- (void)notifyNeedsLayout:(BOOL)animated;

#pragma mark Attributes

/*!
 Add a list of attributed that will call setNeedsDisplay and setNeedsLayout on change.
 */
- (void)setAttributesNeedUpdate:(NSArray *)attributes;

#pragma mark Refresh

- (void)refresh;

- (void)refreshIfNeeded;

@end
