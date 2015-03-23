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

- (NSArray *)parseOption:(NSString *)option isFloat:(BOOL)isFloat minCount:(NSInteger)minCount {
  if (!option) return nil;

  NSMutableArray *options = [NSMutableArray array];
  if ([option isKindOfClass:NSString.class]) {
    NSArray *split = [option componentsSeparatedByString:@","];
    for (NSString *o in split) {
      if (isFloat) [options addObject:@([o floatValue])];
      else [options addObject:@([o integerValue])];
    }
  } else {
    [options addObject:option];
  }
  if ([options count] < minCount) return nil;
  return options;
}

- (void)setOptions:(NSDictionary *)options {
  NSArray *insets = [self parseOption:options[@"insets"] isFloat:YES minCount:1];
  if (insets) {
    if ([insets count] == 4) {
      self.insets = UIEdgeInsetsMake([insets[0] floatValue], [insets[1] floatValue], [insets[2] floatValue], [insets[3] floatValue]);
    } else {
      self.insets = UIEdgeInsetsMake([insets[0] floatValue], [insets[0] floatValue], [insets[0] floatValue], [insets[0] floatValue]);
    }
  }
  self.spacing = [options[@"spacing"] floatValue];
}

@end
