<p align="center" >
  <img src="https://raw.github.com/YOLayout/YOLayout/assets/Logo.png" alt="YOLayout" title="YOLayout">
</p>

[![Version](http://cocoapod-badges.herokuapp.com/v/YOLayout/badge.png)](http://cocoadocs.org/docsets/YOLayout)
[![Platform](http://cocoapod-badges.herokuapp.com/p/YOLayout/badge.png)](http://cocoadocs.org/docsets/YOLayout)

A frame-based layout framework. Avoid Interface Builder and Auto Layout and take full control over your layouts.

## Usage

Let's just jump into the code.

```objc
// TableViewCellView.h
#import <YOLayout/YOLayout.h>

@interface TableViewCellView : YOView // Subclass YOView
@end
```

Here is an example of a view with an image, title label, and multi-line description label with a dynamic height.

```objc
// TableViewCellView.m
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
  self.viewLayout = [YOLayout layoutWithLayoutBlock:^CGSize(id<YOLayout> layout, CGSize size) {
    UIEdgeInsets insets = UIEdgeInsetsMake(10, 10, 10, 10); // Insets for padding
    CGFloat x = insets.left;
    CGFloat y = insets.top;

    // imageView's size is set by the UIImage when using initWithImage:
    CGRect imageViewFrame = [layout setOrigin:CGPointMake(x, y) view:imageView options:0];
    x += imageViewFrame.size.width + 10;

    y += [layout sizeToFitVerticalInFrame:CGRectMake(x, y, size.width - x - insets.right, 0) view:yself.titleLabel].size.height;
    y += [layout sizeToFitVerticalInFrame:CGRectMake(x, y, size.width - x - insets.right, 1000) view:yself.descriptionLabel].size.height;

    // Ensure the y position is at least as high as the image view
    y = MAX(y, (imageViewFrame.origin.y + imageViewFrame.size.height));

    // The height depends on the height of the items in the layout
    return CGSizeMake(size.width, y + insets.bottom);
  }];
}
```

![TableViewCell.png](https://raw.githubusercontent.com/YOLayout/YOLayout/master/YOLayoutExample/YOLayoutExample/DynamicTableViewCells/TableViewCell.png)

If you're following along closely, you may have noticed that there's no reason you _need_ to create a new YOView subclass to use YOLayout. For simple views you can instantiate a YOView and set its layout without creating a new YOView subclass.

Here is an example of a border layout, with a dynamic top and bottom view, and the center view fills the remaining space:

```objc
- (void)viewInit {
  [super viewInit];
  self.backgroundColor = [UIColor lightGrayColor];

  UILabel *topView = [[UILabel alloc] init];
  topView.font = [UIFont systemFontOfSize:20];
  topView.text = @"Top View";
  topView.numberOfLines = 0;
  topView.textAlignment = NSTextAlignmentCenter;
  topView.backgroundColor = [UIColor redColor];
  [self addSubview:topView];

  UILabel *centerView = [[UILabel alloc] init];
  centerView.font = [UIFont systemFontOfSize:20];
  centerView.text = @"Center View";
  centerView.numberOfLines = 0;
  centerView.textAlignment = NSTextAlignmentCenter;
  centerView.backgroundColor = [UIColor blueColor];
  centerView.textColor = [UIColor whiteColor];
  [self addSubview:centerView];

  UILabel *bottomView = [[UILabel alloc] init];
  bottomView.font = [UIFont systemFontOfSize:20];
  bottomView.text = @"Bottom View";
  bottomView.numberOfLines = 0;
  bottomView.textAlignment = NSTextAlignmentCenter;
  bottomView.backgroundColor = [UIColor orangeColor];
  [self addSubview:bottomView];

  UIEdgeInsets margin = UIEdgeInsetsMake(20, 20, 20, 20);
  CGFloat padding = 10;

  self.viewLayout = [YOLayout layoutWithLayoutBlock:^CGSize(id<YOLayout> layout, CGSize size) {
    // Size inset by margin
    CGSize sizeInset = CGSizeMake(size.width - margin.left - margin.right, size.height - margin.top - margin.bottom);

    CGSize topSize = [topView sizeThatFits:sizeInset];
    CGSize bottomSize = [bottomView sizeThatFits:sizeInset];

    // Calculate the height to fill the center
    CGFloat centerHeight = sizeInset.height - topSize.height - bottomSize.height - (padding * 2);

    // Size and position the views
    CGFloat y = margin.top;
    y += [layout setFrame:CGRectMake(margin.left, y, sizeInset.width, topSize.height) view:topView].size.height + padding;

    y += [layout setFrame:CGRectMake(margin.left, y, sizeInset.width, centerHeight) view:centerView].size.height + padding;

    y += [layout setFrame:CGRectMake(margin.left, y, sizeInset.width, bottomSize.height) view:bottomView].size.height;

    return size;
  }];
}
```

![BorderView.png](https://raw.githubusercontent.com/YOLayout/YOLayout/master/YOLayoutExample/YOLayoutExample/BorderView/BorderView.png)

## Example Project

The best way to follow and learn YOLayout is by seeing it in action. Open the example project: [YOLayoutExample](https://github.com/YOLayout/YOLayout/tree/master/YOLayoutExample). It contains both a iOS and OSX targets.

## NSView

NSView and Cocoa is supported. YOLayout makes layout consistent for both UIKit and Cocoa.

## FAQ

### Why do layout in code when we have Interface Builder?

Have you ever tried to do a significant project in IB? It's maddening. Small tweaks can break Auto Layout constraints in unexpected ways. Plus, Interface Builder isn't great for projects with multiple committers; git-merging storyboards and xibs can be very difficult. Ultimately we're coders; we like to do things with code.

### OK, so why not just use AutoLayout in code?

Auto Layout in code is a step in the right direction but carries several disadvantages to frame-based layouts:

* Auto Layout is generally slower than frame-based layouts. [Here's an excellent writeup](http://pilky.me/36/) on the performance disadvantage of Auto Layout.
* Auto Layout can also be tricky to animate, since you need to animate all the relevant constraints.
* Auto Layout debugging can be hellish because there is little transparency into what is happening on the inside. With YOLayout, you have full visibility into the layout process. If your layout breaks, just step through the layout code and see what went wrong! Easy.

### So why not just write your own layout code in `layoutSubviews`?

The core problem with writing your layout code in `layoutSubviews` is the massive duplication of layout code you have to write in both `layoutSubviews` and `sizeThatFits:`. When you have multiple subviews that themselves may size themselves dynamically, this code gets repetitive and tricky to maintain. You can't call `layoutIfNeeded` in `sizeThatFits:` without the risk of infinite recursion if a superview uses your `sizeThatFits:` method in its `layoutSubviews`.

### Will it lay out views that aren't in the view hierarchy?

You probably weren't asking this question, but you should have! One of the neat things about YOLayout is that layouts also work for views that get drawn in `drawRect:`. Because YOLayout works independently from the view hierarchy, you can easily switch between adding a subview to the hierarchy, or just drawing it in `drawRect:` without having to change your layout code. Try to do that with Auto Layout!

YOLayout is a great fit for custom drawn controls. Views that render in `drawRect:` can use the [`IB_DESIGNABLE`](https://developer.apple.com/library/ios/recipes/xcode_help-IB_objects_media/chapters/CreatingaLiveViewofaCustomObject.html) attribute to be rendered live in interface builder. Open up the example project (`pod try YOLayout`) and take a look at [DrawableView.m](https://github.com/YOLayout/YOLayout/blob/master/YOLayoutExample/YOLayoutExample/DrawableViews/DrawableView.m) and DrawableView.xib.

### What is viewInit?

`- (void)viewInit;` is the unified initializer for views. With YOLayout there is no need to specify a default frame or handle initialization differently if the view is from Interface Builder or from code.

### Do I have to use YOLayout for all my views?

Nope. If your layout is really simple, or it doesn't have dynamic sizing, just use `layoutSubviews` (UIKit) or `layout` (AppKit) like you normally would. YOLayout doesn't do anything special to override behavior and is compatible with existing layout methods.

## Disadvantages of using YOLayout

YOLayout, like most things, has trade-offs. We like using it especially for really complex layouts with lots of different alignments and for things that are dynamically sized.

But there are downsides:

- You might find yourself hardcoding pixel values for things like padding, a lot.
- If you are tweaking padding and positioning, you have to re-run the project to visualize those changes, whereas in Interface Builder you would see those changes immediately. (Unless your view is IB_DESIGNABLE which YOLayout supports.)
- Autolayout works really well in certain cases and easier to read than manual layout code.
- YOLayout is a custom framework whereas Interface Builder and AutoLayout are part of Apple and their SDK.

And probably many more, feel free to tell us why you hate it, by submitting an [issue](https://github.com/YOLayout/YOLayout/issues).

## Dependencies

There are none!

## Installation

YOLayout is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "YOLayout"


## Box Model

The `YOLayout/Box` subspec has a box model `YOVBox` and `YOHBox`. This is an example of an application of YOLayout that you might find useful.

`YOVBox` is for vertical layout, and `YOHBox` is for horizontal layout. For example:

```objc
#import <YOLayout/YOBox.h>

@interface BoxExample : YOVBox
@end

@implementation BoxExample

- (void)viewInit {
  [super viewInit];
  self.backgroundColor = UIColor.whiteColor;

  YOVBox *contentView = [YOVBox box:@{@"spacing": @(10), @"insets": @(20)}];
  [self addSubview:contentView];

  UILabel *label1 = [[UILabel alloc] init];
  label1.text = @"Box Model Test";
  label1.font = [UIFont boldSystemFontOfSize:20];
  label1.textAlignment = NSTextAlignmentCenter;
  [contentView addSubview:label1];

  UILabel *label2 = [[UILabel alloc] init];
  label2.font = [UIFont systemFontOfSize:14];
  label2.numberOfLines = 0;
  label2.text = @"PBR&B Intelligentsia shabby chic. Messenger bag flexitarian cold-pressed VHS 90's. Tofu chillwave pour-over Marfa cold-pressed, kogi bespoke High Life semiotics readymade authentic wolf sriracha craft beer. Next level direct trade shabby chic vegan cliche. Mlkshk butcher church-key cornhole 3 wolf moon, YOLO cold-pressed cronut";
  [contentView addSubview:label2];

  YOHBox *buttons = [YOHBox box:@{@"spacing": @(20), @"insets": YOBoxInsets(20, 0, 20, 0)}];

  UIButton *button1 = [self buttonWithText:@"Button"];
  [buttons addSubview:button1];

  UIButton *button2 = [self buttonWithText:@"Button (2)"];
  [buttons addSubview:button2];

  UIButton *button3 = [self buttonWithText:@"Button"];
  [buttons addSubview:button3];

  [contentView addSubview:buttons];
}

@end
```

![BoxView.png](https://raw.githubusercontent.com/YOLayout/YOLayout/master/YOLayoutExample/YOLayoutExample/BoxView/BoxView.png)

## License

YOLayout is available under the MIT license. See the LICENSE file for more info.
