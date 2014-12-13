# YOLayout

A simple frame-based layout framework. All the performance of frame-based layout with an API simpler to use than Auto Layout. Have full control over your layouts. Stop wasting your time with IB and Auto Layout, after all, [YOLO!](http://en.wikipedia.org/wiki/YOLO_%28motto%29)

## Usage

Let's just jump into the code. Here's the header file.

```Objective-C
// MyView.h
#import <YOLayout/YOView.h>

//! A view that sizes vertically based the size of its subviews
@interface MyView : YOView
@end
```

Here's the implementation file. This view's height can change based on the DynamicHeightSubview's height at layout.
```Objective-C
// MyView.m
#import "MyView.h"

@implementation MyView

// sharedInit is called from both initWithFrame: and initWithCoder:
- (void)sharedInit {
    // Create this view's subviews
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MyImage.png"]];
    [self addSubview:imageView];
    DynamicHeightSubview *dynamicHeightSubview = [[DynamicHeightSubview alloc] init];
    [self addSubview:dynamicHeightSubview];
 
    // Define the layout using code, and math!
    [self setLayoutBlock:^(id<YOLayout> layout, MyView *self, CGSize size) {
        CGFloat x = 10;
        CGFloat y = 10;
 
        // Instead of setting frames directly, we use the corresponding layout methods.
        // These methods don't actually change the subviews' frames when the view is just sizing.
        x += [layout setOrigin:CGPointMake(x, y) view:_imageView].size.width + 10;

        y += [layout setFrame:CGRectMake(x, y, size.width - x - 10, 0) sizeThatFits:YES].size.height;

        // The size this view should be
        return CGSizeMake(size.width, y);
    }];
}

@end
```

If you're following along closely, you may have noticed that there's no reason you _need_ to create a new YOView subclass to use YOLayout. For example, you can create simple YOViews inside view controllers.

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

### Will it lay out views not in the view hierarchy?

You probably weren't asking this question, but you should have! One of the neat things about YOLayout is that layouts also work for views that get drawn in `drawRect:`. Because YOLayout works independently from the view hierarchy, you can easily switch between adding a subview to the hierarchy, or just drawing it in `drawRect:` without having to change your layout code. Try to do that with Auto Layout!

## Dependencies

There are none!

## Installation

YOLayout is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "YOLayout"


## License

YOLayout is available under the MIT license. See the LICENSE file for more info.
