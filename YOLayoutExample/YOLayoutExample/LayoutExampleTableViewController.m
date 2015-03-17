//
//  LayoutExampleTableViewController.m
//  YOLayoutExample
//
//  Created by John Boiles on 12/16/14.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

#import "LayoutExampleTableViewController.h"
#import "LogoView.h"
#import "TableViewController.h"
#import "DrawableViewController.h"
#import "BorderViewController.h"
#import "BoxViewController.h"
#import "YOLayoutExample-swift.h"

@interface LayoutExampleTableViewController ()

@end

@implementation LayoutExampleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"YOLayout Examples";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Table View Example";
            cell.detailTextLabel.text = @"Use YOLayout to create dynamic height cells";
            break;

        case 1:
            cell.textLabel.text = @"Drawable View Example";
            cell.detailTextLabel.text = @"Use YOLayout with drawRect:";
            break;

        case 2:
            cell.textLabel.text = @"Border Layout Example";
            cell.detailTextLabel.text = @"Dynamic top and bottom view with center filling the remaining space.";
            break;

        case 3:
            cell.textLabel.text = @"Box Layout Example";
            cell.detailTextLabel.text = @"VBox and HBox";
            break;

        case 4:
            cell.textLabel.text = @"Swift Example";
            cell.detailTextLabel.text = @"Use YOLayout with swift";
            break;

        default:
            return nil;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            TableViewController *tableViewController = [[TableViewController alloc] init];
            [self.navigationController pushViewController:tableViewController animated:YES];
            break;
        }
        case 1:
        {
            DrawableViewController *drawableViewController = [[DrawableViewController alloc] init];
            [self.navigationController pushViewController:drawableViewController animated:YES];
            break;
        }
        case 2:
        {
            BorderViewController *borderViewController = [[BorderViewController alloc] init];
            [self.navigationController pushViewController:borderViewController animated:YES];
            break;
        }
        case 3:
        {
            BoxViewController *boxViewController = [[BoxViewController alloc] init];
            [self.navigationController pushViewController:boxViewController animated:YES];
            break;
        }

        case 4:
        {
            SwiftViewController *swiftViewController = [[SwiftViewController alloc] init];
            [self.navigationController pushViewController:swiftViewController animated:YES];
            break;
        }
        default:
            break;
    }

}

@end
