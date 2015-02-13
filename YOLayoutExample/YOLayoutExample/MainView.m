//
//  LayoutExampleTableViewController.m
//  YOLayoutExample
//
//  Created by John Boiles on 12/16/14.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

#import "MainView.h"
#import "TableViewController.h"
#import "DrawableViewController.h"
#import "CompatibilityTestView.h"
#import <GHUITable/GHUITable.h>

@implementation MainView

- (void)viewInit {
  [super viewInit];
  self.navigationTitle = @"Examples";

  GHUITableView *tableView = [[GHUITableView alloc] init];
  [self addSubview:tableView];

  UITableViewCell *cell1 = [[UITableViewCell alloc] init];
  cell1.textLabel.text = @"Table View Example";
  cell1.detailTextLabel.text = @"Use YOLayout to create dynamic height cells";

  UITableViewCell *cell2 = [[UITableViewCell alloc] init];
  cell2.textLabel.text = @"Drawable View Example";
  cell2.detailTextLabel.text = @"Use YOLayout with drawRect:";

  UITableViewCell *cell3 = [[UITableViewCell alloc] init];
  cell3.textLabel.text = @"Compatibilty View Example";
  cell3.detailTextLabel.text = @"Use YOLayout for views in iOS and OSX";

  [tableView addObjects:@[cell1, cell2, cell3] section:0 animated:NO];

  tableView.dataSource.selectBlock = ^(UITableView *tableView, NSIndexPath *indexPath, UIView *view) {
    NSLog(@"Selected: %@", indexPath);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.row == 0) {
      TableViewController *tableViewController = [[TableViewController alloc] init];
      [self.navigation.viewController.navigationController pushViewController:tableViewController animated:YES];
    } else if (indexPath.row == 1) {
      DrawableViewController *tableViewController = [[DrawableViewController alloc] init];
      [self.navigation.viewController.navigationController pushViewController:tableViewController animated:YES];
    } else if (indexPath.row == 2) {
      CompatibilityTestView *view = [[CompatibilityTestView alloc] init];
      [self.navigation pushView:view animated:YES];
    }
  };

  self.layout = [YOLayout fill:tableView];
}

@end
