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

@interface LayoutExampleTableViewController ()

@end

@implementation LayoutExampleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"YOLayout Example";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Table View Example";
            cell.detailTextLabel.text = @"Use YOLayout to create dynamic height cells";
            break;
            
        default:
            cell.textLabel.text = @"Drawable View Example";
            cell.detailTextLabel.text = @"Use YOLayout with drawRect:";

            break;
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
        default:
            break;
    }

}

@end
