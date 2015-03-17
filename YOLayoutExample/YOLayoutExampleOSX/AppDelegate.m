//
//  AppDelegate.m
//  YOLayoutExampleOSX
//
//  Created by Gabriel on 1/20/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "AppDelegate.h"

#import "YONSTestView.h"
#import "YOBoxTestView.h"

@interface AppDelegate ()
@property NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  YOVBox *contentView = [YOVBox box];
  YONSTestView *testView1 = [[YONSTestView alloc] init];
  [contentView addSubview:testView1];

  YOBoxTestView *boxView = [[YOBoxTestView alloc] init];
  [contentView addSubview:boxView];

  _window = [self windowForContentView:contentView];
  [_window makeKeyAndOrderFront:nil];
}

- (NSWindow *)windowForContentView:(NSView *)contentView {
  NSWindow *window = [[NSWindow alloc] init];
  window.styleMask = NSClosableWindowMask | NSResizableWindowMask | NSFullSizeContentViewWindowMask | NSTitledWindowMask;
  window.titleVisibility = NSWindowTitleHidden;
  window.titlebarAppearsTransparent = YES;
  window.movableByWindowBackground = YES;
  [contentView setFrame:CGRectMake(0, 0, 600, 600)];
  [window setContentSize:CGSizeMake(600, 600)];
  [window setContentView:contentView];
  return window;
}

@end
