//
//  GridView.m
//  YOLayoutExample
//
//  Created by John Boiles on 12/16/14.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

#import "GridView.h"
#import "LogoView.h"

@implementation GridView

- (void)sharedInit {
    [super sharedInit];

    for (NSInteger i = 0; i < 10; i++) {
        LogoView *logoView = [[LogoView alloc] init];
        logoView.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0];
        [self addSubview:logoView];
    }
    
    self.layout = [YOLayout layoutWithLayoutBlock:^CGSize(id<YOLayout> layout, CGSize size) {
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat maxWidth = 0;
        
        // Lay out each view at 150pt wide with as many columns as will fit and as many rows as necessary
        CGFloat subviewWidth = 150;
        for (UIView *subview in self.subviews) {
            CGSize subviewSize = [layout setFrame:CGRectMake(x, y, subviewWidth, 0) view:subview sizeToFit:YES].size;
            x += subviewSize.width;
            // Wrap when there's not enough horizontal space to render another view
            if ((x + subviewWidth) > size.width && ![subview isEqual:[self.subviews lastObject]]) {
                y += subviewSize.height;
                maxWidth = x;
                x = 0;
            }
            if ([subview isEqual:self.subviews.lastObject]) {
                y += subviewSize.height;
            }
        }

        // Size of this view depends on the number of rows required
        return CGSizeMake(maxWidth, y);
    }];
}

@end
