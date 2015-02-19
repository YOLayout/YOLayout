//
//  BorderViewController.m
//  YOLayoutExample
//
//  Created by Gabriel on 2/19/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "BorderViewController.h"

#import "BorderView.h"

@implementation BorderViewController

- (void)loadView {
  self.edgesForExtendedLayout = UIRectEdgeNone;
  self.view = [[BorderView alloc] init];
}

@end
