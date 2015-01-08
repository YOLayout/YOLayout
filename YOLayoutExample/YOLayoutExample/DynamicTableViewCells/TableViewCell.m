//
//  TableViewCell.m
//  YOLayoutExample
//
//  Created by John Boiles on 12/16/14.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCellView ()
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIImageView *iconImageView;
- (void)setString:(NSString *)string;
@end

@implementation TableViewCellView

- (void)sharedInit {
    self.iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"information.png"]];
    [self addSubview:self.iconImageView];
    
    self.label = [[UILabel alloc] init];
    // To make a label wrap, you need to set numberOfLines != 1 and lineBreakMode
    self.label.numberOfLines = 0;
    self.label.lineBreakMode = NSLineBreakByWordWrapping;
    [self addSubview:self.label];

    __weak typeof(self) weakSelf = self;
    self.layout = [YOLayout layoutWithView:self layoutBlock:^CGSize(id<YOLayout> layout, TableViewCellView *view, CGSize size) {
        UIEdgeInsets insets = UIEdgeInsetsMake(10, 10, 10, 10);
        CGFloat x = insets.left;
        CGFloat y = insets.top;
        
        // iconImageView's size is set by the UIImage when using initWithImage:
        CGSize imageViewSize = [layout setOrigin:CGPointMake(x, y) view:weakSelf.iconImageView].size;
        x += imageViewSize.width + 10;

        // Lay out the text
        CGSize textSize = [layout setFrame:CGRectMake(x, y, size.width - x - insets.right, 1000) view:weakSelf.label options:YOLayoutOptionsSizeToFit].size;

        // Increment by whichever view is taller, the image or the text
        y += MAX(imageViewSize.height, textSize.height);

        // The height depends on the height of the items in the layout
        return CGSizeMake(size.width, y + insets.bottom);
    }];
}

- (void)setString:(NSString *)string {
    self.label.text = string;
    [self setNeedsLayout];
}

@end


@implementation TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Set up our custom view as a subview of self.contentView
        self.view = [[TableViewCellView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.width)];
        [self.contentView addSubview:self.view];
        // Set up our subview to have its width dynamically sized by contentView
        self.contentView.autoresizesSubviews = YES;
        self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

- (void)setString:(NSString *)string {
    _string = string;
    [self.view setString:string];
}

@end
