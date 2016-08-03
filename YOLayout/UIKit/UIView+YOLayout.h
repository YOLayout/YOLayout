//
//  UIView+YOLayout.h
//  YOLayoutExample
//
//  Created by Lucas Yan on 8/1/16.
//  Copyright © 2016 YOLayout. All rights reserved.
//

@import UIKit;
#import "YOLayout.h"

/*!
 Inject necessary YOLayout methods into a UIView subclass using swizzling. Useful for using YOLayout with UIView subclasses where it's difficult to change the view hierarchy. Or simply for trying out YOLayout with minimal commitment.

 To use, call `useYOLayout` in the view class's `load` method. You can then set `self.layout` as in YOView.

     + (void)load {
         [self useYOLayout];
     }

     - (void)viewInit {
         self.layout = [YOLayout layoutWithLayoutBlock:^CGSize(YOLayout * _Nonnull layout, CGSize size) {
             // Layout code here
             return size;
         }];
     }
 */
@interface UIView (YOLayout)

@property (nonatomic) YOLayout *layout;

/*!
 Inject necessary YOLayout methods into a UIView subclass using swizzling. Should be called from `load`.
*/
+ (void)useYOLayout;

/*!
 Subclasses can implement this method to perform initialization tasks that occur during both initWithFrame: and initWithCoder:
 */
- (void)viewInit;

/*!
 Force the layout, if using YOLayout.
 You can use this instead of setNeedsLayout + layoutIfNeeded.
 This is also useful when using animations and setNeedsLayout + layoutIfNeeded don't work as expected.
 */
- (void)layoutView;

@end
