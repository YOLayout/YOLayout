//
//  YONSButton.h
//  YOLayoutExample
//
//  Created by Gabriel on 1/20/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import <Foundation/Foundation.h>

@import AppKit;

typedef void (^KBButtonTargetBlock)();

@interface YONSButton : NSButton

@property (nonatomic, copy) KBButtonTargetBlock targetBlock;

+ (instancetype)buttonWithText:(NSString *)text;

+ (instancetype)buttonWithImage:(NSImage *)image;

- (void)setText:(NSString *)text font:(NSFont *)font color:(NSColor *)color alignment:(NSTextAlignment)alignment;


@end
