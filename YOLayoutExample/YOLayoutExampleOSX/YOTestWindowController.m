//
//  YOTestWindowController.m
//  YOLayoutExample
//
//  Created by Gabriel on 1/20/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "YOTestWindowController.h"

#import "YONSTestView.h"

@implementation YOTestWindowController

- (void)windowDidLoad {
  self.window.styleMask = self.window.styleMask | NSFullSizeContentViewWindowMask;
  self.window.titleVisibility = NSWindowTitleHidden;
  self.window.titlebarAppearsTransparent = YES;
  self.window.movableByWindowBackground = YES;

  [self.window setContentSize:CGSizeMake(600, 600)];

  YONSTestView *testView = [[YONSTestView alloc] init];

//  NSScrollView *scrollView = [[NSScrollView alloc] init];
//  [scrollView setHasVerticalScroller:YES];
//  [scrollView setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
//  [scrollView setDocumentView:testView];

  self.window.contentView = testView;
}

@end
