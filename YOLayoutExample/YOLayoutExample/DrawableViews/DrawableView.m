//
//  DrawableView.m
//  YOLayoutExample
//
//  Created by John Boiles on 12/16/14.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

#import "DrawableView.h"
#import "LogoView.h"

@interface DrawableView ()
@property (strong, nonatomic) NSMutableArray *drawableSubviews;
@end

@implementation DrawableView

//! sharedInit is a convenience method of YOView which is called from both initWithCoder: and initWithFrame:. It eliminates the need to duplicate code in both those places.
- (void)sharedInit {
    self.backgroundColor = [UIColor whiteColor];

    // Storage for our drawable views
    self.drawableSubviews = [[NSMutableArray alloc] init];

    // Create the views
    for (NSInteger i = 0; i < 10; i++) {
        LogoView *logoView = [[LogoView alloc] init];
        [self.drawableSubviews addObject:logoView];
    }

    // Instantiate the layout
    self.layout = [YOLayout layoutWithLayoutBlock:^CGSize(id<YOLayout> layout, CGSize size) {
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat maxWidth = 0;

        // Lay out each view at 150pt wide with as many columns as will fit and as many rows as necessary
        CGFloat subviewWidth = 150;
        for (UIView *subview in self.drawableSubviews) {
            CGSize subviewSize = [layout setFrame:CGRectMake(x, y, subviewWidth, 0) view:subview sizeToFit:YES].size;
            x += subviewSize.width;
            // Wrap when there's not enough horizontal space to render another view
            if ((x + subviewWidth) > size.width && ![subview isEqual:[self.drawableSubviews lastObject]]) {
                y += subviewSize.height;
                maxWidth = x;
                x = 0;
            }
            if ([subview isEqual:self.drawableSubviews.lastObject]) {
                y += subviewSize.height;
            }
        }
        // Size of this view depends on the number of rows required
        return CGSizeMake(maxWidth, y);
    }];
}

- (void)drawRect:(CGRect)rect {
    // Render each of our 'subviews'
    for (UIView<YODrawableView> *subview in self.drawableSubviews) {
        [subview drawInRect:subview.frame];
    }
}

@end
