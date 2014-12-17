//
//  YOLabel.m
//  Orbital
//
//  Created by John Boiles on 12/11/14.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

#import "YOLabel.h"

@implementation YOLabel

- (CGSize)sizeThatFits:(CGSize)size
{
    if (self.numberOfLines == 1) {
        return [super sizeThatFits:size];
    } else {
        CGRect textRect = [self.attributedText boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) context:nil];
        return CGSizeMake(ceilf(textRect.size.width), ceilf(textRect.size.height));
    }
}

@end
