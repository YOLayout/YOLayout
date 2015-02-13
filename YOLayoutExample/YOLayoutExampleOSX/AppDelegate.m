//
//  AppDelegate.m
//  YOLayoutExampleOSX
//
//  Created by Gabriel on 1/20/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "AppDelegate.h"

#import "YONSTestView.h"
#import "CompatibilityTestView.h"

@interface AppDelegate ()
@property NSWindow *window;
@property NSWindow *window2;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  YONSTestView *testView = [[YONSTestView alloc] init];
  _window = [self windowForContentView:testView size:CGSizeMake(600, 600)];
  [_window makeKeyAndOrderFront:nil];

  CompatibilityTestView *compatView = [[CompatibilityTestView alloc] init];
  _window2 = [self windowForContentView:compatView size:CGSizeMake(400, 200)];
  [_window2 makeKeyAndOrderFront:nil];
}

- (NSWindow *)windowForContentView:(NSView *)contentView size:(CGSize)size {
  NSWindow *window = [[NSWindow alloc] init];
  window.styleMask = NSClosableWindowMask | NSResizableWindowMask | NSFullSizeContentViewWindowMask | NSTitledWindowMask;
  window.titleVisibility = NSWindowTitleHidden;
  window.titlebarAppearsTransparent = YES;
  window.movableByWindowBackground = YES;
  [window setContentSize:size];
  [window setContentView:contentView];
  return window;
}

@end
