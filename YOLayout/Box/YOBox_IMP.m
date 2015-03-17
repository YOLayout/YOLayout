//
//  YOBox.m
//  YOLayoutExample
//
//  Created by Gabriel on 3/13/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "YOBox.h"

@implementation YOBox

+ (instancetype)box {
  return [[self alloc] init];
}

+ (instancetype)box:(NSDictionary *)options {
  YOBox *box = [[self alloc] init];
  [box setOptions:options];
  return box;
}

- (void)setOptions:(NSDictionary *)options {
  id insets = options[@"insets"];
  if (insets) {
    if ([insets isKindOfClass:NSArray.class]) {
      if ([insets count] != 4) {
        [NSException raise:NSInvalidArgumentException format:@"Invalid insets"];
        return;
      }
      self.insets = UIEdgeInsetsMake([insets[0] floatValue], [insets[1] floatValue], [insets[2] floatValue], [insets[3] floatValue]);
    } else {
      self.insets = UIEdgeInsetsMake([insets floatValue], [insets floatValue], [insets floatValue], [insets floatValue]);
    }
  }
  self.spacing = [options[@"spacing"] floatValue];
}

@end
