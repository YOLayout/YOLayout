//
//  TableViewCell.m
//  YOLayoutExample
//
//  Created by John Boiles on 12/16/14.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCellView ()
@property (strong, nonatomic) UILabel *label1;
@property (strong, nonatomic) UILabel *label2;
@property (strong, nonatomic) UIImageView *iconImageView;
@end

@implementation TableViewCellView

- (void)viewInit {
    [super viewInit];
    self.iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"information.png"]];
    [self addSubview:self.iconImageView];
    
    self.label1 = [[UILabel alloc] init];
    self.label1.numberOfLines = 1;
    self.label1.lineBreakMode = NSLineBreakByTruncatingTail;
    self.label1.font = [UIFont boldSystemFontOfSize:16];
    [self addSubview:self.label1];

    self.label2 = [[UILabel alloc] init];
    // To make a label wrap, you need to set numberOfLines != 1 and lineBreakMode
    self.label2.numberOfLines = 0;
    self.label2.font = [UIFont systemFontOfSize:16];
    self.label2.lineBreakMode = NSLineBreakByWordWrapping;
    [self addSubview:self.label2];

    YOSelf yself = self;
    self.layout = [YOLayout layoutWithLayoutBlock:^CGSize(id<YOLayout> layout, CGSize size) {
        UIEdgeInsets insets = UIEdgeInsetsMake(10, 10, 10, 10);
        CGFloat x = insets.left;
        CGFloat y = insets.top;
        
        // iconImageView's size is set by the UIImage when using initWithImage:
        CGRect imageViewFrame = [layout setOrigin:CGPointMake(x, y) view:yself.iconImageView options:0];
        x += imageViewFrame.size.width + 10;

        if (![yself.label1.text isEqualToString:@""]) {
          y += [layout setFrame:CGRectMake(x, y, size.width - x - insets.right, 0) view:yself.label1 options:YOLayoutOptionsSizeToFitVertical].size.height;
        }

        y += [layout setFrame:CGRectMake(x, y, size.width - x - insets.right, 1000) view:yself.label2 options:YOLayoutOptionsSizeToFitVertical].size.height;

        // Ensure the y position is at least as high as the image view
        if (y < (imageViewFrame.origin.y + imageViewFrame.size.height)) y = (imageViewFrame.origin.y + imageViewFrame.size.height);

        // The height depends on the height of the items in the layout
        return CGSizeMake(size.width, y + insets.bottom);
    }];
}

- (void)setText:(NSString *)text description:(NSString *)description {
    self.label1.text = text;
    self.label2.text = description;
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

- (void)setText:(NSString *)text description:(NSString *)description {
    [self.view setText:text description:description];
}

@end
