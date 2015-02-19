//
//  TableViewCell.m
//  YOLayoutExample
//
//  Created by John Boiles on 12/16/14.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCellView ()
@property UILabel *titleLabel;
@property UILabel *descriptionLabel;
@end

@implementation TableViewCellView

- (void)viewInit {
  [super viewInit];
  UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"information.png"]];
  [self addSubview:imageView];
  
  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.numberOfLines = 1;
  self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
  self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
  [self addSubview:self.titleLabel];

  self.descriptionLabel = [[UILabel alloc] init];
  self.descriptionLabel.font = [UIFont systemFontOfSize:16];
  self.descriptionLabel.numberOfLines = 0; // Multi-line label (word wrapping
  self.descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
  [self addSubview:self.descriptionLabel];

  YOSelf yself = self;
  self.layout = [YOLayout layoutWithLayoutBlock:^CGSize(id<YOLayout> layout, CGSize size) {
    UIEdgeInsets insets = UIEdgeInsetsMake(10, 10, 10, 10);
    CGFloat x = insets.left;
    CGFloat y = insets.top;
    
    // imageView's size is set by the UIImage when using initWithImage:
    CGRect imageViewFrame = [layout setOrigin:CGPointMake(x, y) view:imageView options:0];
    x += imageViewFrame.size.width + 10;

    if (![yself.titleLabel.text isEqualToString:@""]) {
      y += [layout setFrame:CGRectMake(x, y, size.width - x - insets.right, 0) view:yself.titleLabel options:YOLayoutOptionsSizeToFitVertical].size.height;
    }

    y += [layout setFrame:CGRectMake(x, y, size.width - x - insets.right, 1000) view:yself.descriptionLabel options:YOLayoutOptionsSizeToFitVertical].size.height;

    // Ensure the y position is at least as high as the image view
    if (y < (imageViewFrame.origin.y + imageViewFrame.size.height)) y = (imageViewFrame.origin.y + imageViewFrame.size.height);

    // The height depends on the height of the items in the layout
    return CGSizeMake(size.width, y + insets.bottom);
  }];
}

- (void)setText:(NSString *)text description:(NSString *)description {
  self.titleLabel.text = text;
  self.descriptionLabel.text = description;
  [self setNeedsLayout];
}

@end


@implementation TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
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
