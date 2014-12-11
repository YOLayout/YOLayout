# YOLayout

A simple frame-based layout framework. All the performance of frame-based layout with an API simpler to use than Auto Layout. Have full control over your layouts. Stop wasting your time with IB and Auto Layout, after all, [YOLO!](http://en.wikipedia.org/wiki/YOLO_%28motto%29)

## Usage

Let's just jump into the code. Here's the header file.

```
// MyView.h
#import <YOLayout/YOUIView.h>

//! A view that sizes vertically based on the height of a label and an image view
@interface MyView : YOUIView
@end
```

Here's the implementation file. This view's height can change based on the DynamicHeightSubview's height at layout.
```
// MyView.m
#import "MyView.h"

@implementation MyView {
    UIImageView *_imageView;
    DynamicHeightSubview *_dynamicHeightSubview;
}

- (void)sharedInit {
    self.layout = [YOLayout layoutWithView:self];

    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MyImage.png"]];
    _dynamicHeightSubview = [[DynamicHeightSubview alloc] init];
}

- (CGSize)layout:(id<YOLayout>)layout size:(CGSize)size {
    // Layout _imageView at its native size (the image's size) 10pt inset from the left and top
	CGRect rect = [layout setOrigin:CGPointMake(10, 10) view:_imageView];
    // Layout _dynamicHeightSubview 10pt to the right of _imageView and 10pt to the right of the bounds. Size vertically to fit.
    rect = [layout setFrame:CGRectMake(CGRectGetMaxX(rect) + 10, rect.origin.y, size.width - (CGRectGetMaxX(rect) + 10), 0) sizeToFit:YES];
    // This view's height is the bottom of _dynamicHeightSubview + 10pt padding at the bottom
    return CGSizeMake(size.width, CGRectGetMaxY(rect) + 10);
}

@end
```

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

## Dependencies

There are none!

## Installation

YOLayout is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "YOLayout"


## License

YOLayout is available under the MIT license. See the LICENSE file for more info.
