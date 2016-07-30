//
//  NestedLayoutView.m
//  YOLayoutExample
//
//  Created by John Boiles on 7/28/16.
//  Copyright © 2016 YOLayout. All rights reserved.
//

#import "NestedLayoutView.h"

@implementation NestedLayoutView

- (void)viewInit {
  self.backgroundColor = [UIColor whiteColor];

  UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"information.png"]];
  [self addSubview:imageView];

  UILabel *titleLabel = [[UILabel alloc] init];
  titleLabel.text = @"This is the title label";
  titleLabel.numberOfLines = 1;
  titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
  titleLabel.font = [UIFont boldSystemFontOfSize:16];
  [self addSubview:titleLabel];

  UILabel *descriptionLabel = [[UILabel alloc] init];
  descriptionLabel.text = @"This is the description label that's longer and wraps to multiple lines so that you can see how the imageView is able to vertically center on the two labels grouped together in a nested layout. This view also gracefully flips for right-to-left locales.";
  descriptionLabel.font = [UIFont systemFontOfSize:16];
  descriptionLabel.numberOfLines = 0; // Multi-line label (word wrapping
  descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
  [self addSubview:descriptionLabel];

  self.layout = [YOLayout layoutWithLayoutBlock:^CGSize(YOLayout *layout, CGSize size) {
    CGFloat x = 10 + imageView.image.size.width + 10;
    CGFloat y = 10;

    // Nested layout for the labels
    YOLayout *labelLayout = [YOLayout layoutWithLayoutBlock:^CGSize(YOLayout *layout, CGSize size) {
      CGFloat y = 0;
      y += [layout setFrame:CGRectMake(0, y, size.width, CGFLOAT_MAX) view:titleLabel options:YOLayoutOptionsSizeToFitVertical].size.height;
      y += [layout setFrame:CGRectMake(0, y, size.width, CGFLOAT_MAX) view:descriptionLabel options:YOLayoutOptionsSizeToFitVertical].size.height;
      return CGSizeMake(size.width, y);
    }];

    CGRect labelsRect = [layout setFrame:CGRectMake(x, y, size.width - x - 10, CGFLOAT_MAX) view:labelLayout options:YOLayoutOptionsSizeToFitVertical | YOLayoutOptionsFlipIfNeededForRTL];

    // Image view should be vertically centered in labelLayout's height
    [layout setSize:imageView.image.size inRect:CGRectMake(10, labelsRect.origin.y, imageView.image.size.width, labelsRect.size.height) view:imageView options:YOLayoutOptionsAlignCenterVertical | YOLayoutOptionsFlipIfNeededForRTL];

    return CGSizeMake(size.width, labelsRect.origin.y + labelsRect.size.height);
  }];
}

@end
