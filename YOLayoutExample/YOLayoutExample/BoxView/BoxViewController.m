//
//  BoxViewController.m
//  YOLayoutExample
//
//  Created by Gabriel on 3/16/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "BoxViewController.h"
#import "BoxView.h"

@implementation BoxViewController

- (void)loadView {
  self.edgesForExtendedLayout = UIRectEdgeNone;
  self.view = [[BoxView alloc] init];
}

@end
