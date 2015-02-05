//
//  AppDelegate.m
//  YOLayoutExampleOSX
//
//  Created by Gabriel on 1/20/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "AppDelegate.h"

#import "YONSTestView.h"

@interface AppDelegate ()
@property NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  YONSTestView *testView = [[YONSTestView alloc] init];
  _window = [self windowForContentView:testView];
  [_window makeKeyAndOrderFront:nil];
}

- (NSWindow *)windowForContentView:(NSView *)contentView {
  NSWindow *window = [[NSWindow alloc] init];
  window.styleMask = NSClosableWindowMask | NSResizableWindowMask | NSFullSizeContentViewWindowMask | NSTitledWindowMask;
  window.titleVisibility = NSWindowTitleHidden;
  window.titlebarAppearsTransparent = YES;
  window.movableByWindowBackground = YES;
  [window setContentSize:CGSizeMake(600, 600)];
  [window setContentView:contentView];
  return window;
}

@end
