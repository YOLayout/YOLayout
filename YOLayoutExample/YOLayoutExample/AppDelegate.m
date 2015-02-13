//
//  AppDelegate.m
//  YOLayoutExample
//
//  Created by John Boiles on 12/13/14.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

#import "AppDelegate.h"
#import "MainView.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

  MainView *mainView = [[MainView alloc] init];
  [mainView setRootNavigationOnWindow:self.window];

  [self.window makeKeyAndVisible];
  return YES;
}

@end
