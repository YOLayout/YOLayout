//
//  TableViewController.m
//  YOLayoutExample
//
//  Created by John Boiles on 12/16/14.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"

@interface TableViewController ()
@property (strong, nonatomic) NSArray */*of NSString*/strings;
@property (strong, nonatomic) TableViewCell *prototypeCell;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Dynamic Height Cells";

    self.strings = @[@"This is a short string",
                     @"This is a longer string that keeps going and will wrap at least once",
                     @"This string is way too long and wraps a bunch of times because it does not end but instead keeps on going so that we can demonstrate how sizing is no problem even if the text goes on and and on.",
                     @"Give it a try in landscape. It works well that way too!"];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.strings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];

    if (!cell) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TableViewCell"];
    }
    cell.string = self.strings[indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Create a prototype cell that we'll use in calculating the heights for rows
    if (!self.prototypeCell) {
        self.prototypeCell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    [self.prototypeCell setString:self.strings[indexPath.row]];
    return [self.prototypeCell.view sizeThatFits:CGSizeMake(tableView.frame.size.width, 0)].height;
}

@end
