//
//  YONSLabel.h
//  YOLayoutExample
//
//  Created by Gabriel on 1/20/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YOLayout.h"

@interface YONSLabel : YOView

@property (nonatomic) NSAttributedString *attributedText;

- (void)setText:(NSString *)text font:(NSFont *)font color:(NSColor *)color alignment:(NSTextAlignment)alignment;

+ (CGSize)sizeThatFits:(CGSize)size attributedString:(NSAttributedString *)attributedString;

@end
