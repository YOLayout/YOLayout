//
//  TableViewCell.m
//  YOLayoutExample
//
//  Created by John Boiles on 12/16/14.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

#import "TableViewCell.h"
#import "UIView+YOLayoutView.h"

@interface TableViewCellView ()
@property UILabel *titleLabel;
@property UILabel *descriptionLabel;
@property UIImageView *imageView;
@end

@implementation TableViewCellView

+ (void)load {
    [self initLayout];
}

- (void)viewInit {
  [super viewInit];
  self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"information.png"]];
  [self addSubview:self.imageView];
  
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
}

- (CGSize)layoutWithLayout:(YOLayout *)layout size:(CGSize)size {
    CGFloat x = 10;
    CGFloat y = 10;
    
    // imageView's size is set by the UIImage when using initWithImage:
    CGRect imageViewFrame = [layout setOrigin:CGPointMake(x, y) view:self.imageView options:0];
    x += imageViewFrame.size.width + 10;
    
    y += [layout sizeToFitVerticalInFrame:CGRectMake(x, y, size.width - x - 10, 0) view:self.titleLabel].size.height;
    y += [layout sizeToFitVerticalInFrame:CGRectMake(x, y, size.width - x - 10, 1000) view:self.descriptionLabel].size.height;
    
    // Ensure the y position is at least as high as the image view
    y = MAX(y, (imageViewFrame.origin.y + imageViewFrame.size.height));
    y += 10;
    
    return CGSizeMake(size.width, y);
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
