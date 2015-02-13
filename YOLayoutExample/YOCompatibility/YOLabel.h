//
//  YONSLabel.h
//  YOLayoutExample
//
//  Created by Gabriel on 1/20/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YOLayout.h"
#import "YOCompatibility.h"

@interface YOLabel : YOView

- (void)setText:(NSString *)text font:(YOFont *)font color:(YOColor *)color alignment:(YOTextAlignment)alignment;

@end
