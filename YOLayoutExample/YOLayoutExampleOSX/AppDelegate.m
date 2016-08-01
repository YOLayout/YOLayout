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
  YOView *contentView = [YOView new];
    
  YONSTestView *testView1 = [[YONSTestView alloc] init];
  [contentView addSubview:testView1];

  contentView.viewLayout = [YOLayout layoutWithLayoutBlock:^CGSize(YOLayout * _Nonnull layout, CGSize size) {
    [layout setFrame:CGRectMake(0, 0, size.width, 0) view:testView1 options:YOLayoutOptionsSizeToFitVertical];
    return size;
  }];
  
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
