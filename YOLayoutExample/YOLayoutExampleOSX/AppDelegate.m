//
//  AppDelegate.m
//  YOLayoutExampleOSX
//
//  Created by Gabriel on 1/20/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "AppDelegate.h"

#import "YOTestWindowController.h"

@interface AppDelegate ()
@property YOTestWindowController *windowController;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  _windowController = [[YOTestWindowController alloc] initWithWindowNibName:@"YOTestWindowController"];
  [_windowController showWindow:nil];
}

@end
