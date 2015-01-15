//
//  TableViewCell.h
//  YOLayoutExample
//
//  Created by John Boiles on 12/16/14.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

#import "YOLayout.h"

@interface TableViewCellView : YOView
@end


@interface TableViewCell : UITableViewCell

@property TableViewCellView *view;

- (void)setText:(NSString *)text description:(NSString *)description;

@end
