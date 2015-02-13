//
//  YOCompatibility.h
//  YOLayoutExample
//
//  Created by Gabriel on 2/12/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>

@interface YOFont : UIFont
@end

@interface YOColor : UIColor
@end

typedef NS_ENUM(NSInteger, YOTextAlignment) {
  YOTextAlignmentLeft = NSTextAlignmentLeft,
  YOTextAlignmentCenter = NSTextAlignmentCenter,
  YOTextAlignmentRight = NSTextAlignmentRight,
};

#else
#import <AppKit/AppKit.h>

@interface YOFont : NSFont
@end

@interface YOColor : NSColor
@end

typedef NS_ENUM(NSInteger, YOTextAlignment) {
  YOTextAlignmentLeft = NSLeftTextAlignment,
  YOTextAlignmentCenter = NSCenterTextAlignment,
  YOTextAlignmentRight = NSRightTextAlignment,
};

#endif

