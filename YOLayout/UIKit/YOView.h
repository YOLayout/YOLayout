//
//  YOView.h
//  YOLayout
//
//  Created by Gabriel Handford on 10/29/13.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YOLayout_IMP.h"

/*!
 View with custom, programatic layout (via YOLayout).
 
 Instead of subclassing UIView, you can subclass YOView and set the layout property.
 See YOLayout for more details.

      - (void)viewInit {
         [super viewInit];
         UIView *subview = [[UIView alloc] init];
         [self addSubview:subview];
         self.layout = [YOLayout layoutWithLayoutBlock:^(id<YOLayout> layout, CGSize size) {
           [layout setFrame:CGRectMake(0, 0, size.width, 30) view:subview];
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
- (void)viewInit;

/*!
 Force the layout, if using YOLayout.
 You can use this instead of setNeedsLayout + layoutIfNeeded.
 This is also useful when using animations and setNeedsLayout + layoutIfNeeded don't work as expected.
 */
- (void)layoutView;

#pragma mark Attributes

/*!
 Add a list of attributes that will call setNeedsDisplay and setNeedsLayout on change.
 */
- (void)setAttributesNeedUpdate:(NSArray *)attributes;

@end
