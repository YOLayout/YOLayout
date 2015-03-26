//
//  YOHBox.h
//  YOLayoutExample
//
//  Created by Gabriel on 3/13/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YOBox_IMP.h"

typedef NS_ENUM(NSInteger, YOHorizontalAlignment) {
  YOHorizontalAlignmentNone,
  YOHorizontalAlignmentLeft,
  YOHorizontalAlignmentCenter,
  YOHorizontalAlignmentRight
};

@interface YOHBox : YOBox

@property YOHorizontalAlignment horizontalAlignment;

@end
