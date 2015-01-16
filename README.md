<p align="center" >
  <img src="https://raw.github.com/YOLayout/YOLayout/assets/Logo.png" alt="YOLayout" title="YOLayout">
</p>

A simple frame-based layout framework. All the performance of frame-based layout with an API simpler to use than Auto Layout. Have full control over your layouts. Stop wasting your time with IB and Auto Layout, after all, [YOLO!](http://en.wikipedia.org/wiki/YOLO_%28motto%29)

## Usage

Let's just jump into the code. Here's the header file for a view that uses YOLayout.

```Objective-C
// MyView.h
#import <YOLayout/YOLayout.h>

//! A view that sizes vertically based the size of its subviews
@interface MyView : YOView
@property UIImageView *imageView;
@property MyCustomView *myCustomView;
@end
```

Here's the implementation file. This view's height can change based on the DynamicHeightSubview's height at layout.
```Objective-C
// MyView.m
#import "MyView.h"

@implementation MyView

// viewInit is called from both initWithFrame: and initWithCoder:
- (void)viewInit {
    [super viewInit];
    // Create this view's subviews
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MyImage.png"]];
    [self addSubview:self.imageView];
    self.myCustomView = [[MyCustomView alloc] init];
    [self addSubview:self.myCustomView];

    // Define the layout using code, and math!

    YOSelf yself = self; // Weak self reference
    self.layout = [YOLayout layoutWithLayoutBlock:^CGSize(id<YOLayout> layout, CGSize size) {
        CGFloat x = 10;
        CGFloat y = 10;

        // Instead of setting frames directly, we use the corresponding layout methods.
        // These methods don't actually change the subviews' frames when the view is just sizing.
        x += [layout setOrigin:CGPointMake(x, y) view:yself.imageView].size.width + 10;

        y += [layout setFrame:CGRectMake(x, y, size.width - x - 10, 0) view:yself.myCustomView sizeToFit:YES].size.height;

        // The size this view should be
        return CGSizeMake(size.width, y);
    }];
}

@end
```

If you're following along closely, you may have noticed that there's no reason you _need_ to create a new YOView subclass to use YOLayout. For simple views you can instantiate a YOView and set its layout without creating a new YOView subclass.

## NSView

Cocoa is supported also by subclassing `YONSView`. When using YOLayout in Cocoa, it acts just like UIKit.
Because layout is reserved for NSView, the layout property is called `viewLayout`.

```objc
#import <YOLayout/YOLayout.h>

@interface MyNSView : YONSView
@end

@implementation MyNSView

- (void)viewInit {
    [super viewInit];
    self.viewLayout = [YOLayout layoutWithLayoutBlock:^CGSize(id<YOLayout> layout, CGSize size) {
        
    }];
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

### Will it lay out views that aren't in the view hierarchy?

You probably weren't asking this question, but you should have! One of the neat things about YOLayout is that layouts also work for views that get drawn in `drawRect:`. Because YOLayout works independently from the view hierarchy, you can easily switch between adding a subview to the hierarchy, or just drawing it in `drawRect:` without having to change your layout code. Try to do that with Auto Layout!

YOLayout is a great fit for custom drawn controls. Views that render in `drawRect:` can use the [`IB_DESIGNABLE`](https://developer.apple.com/library/ios/recipes/xcode_help-IB_objects_media/chapters/CreatingaLiveViewofaCustomObject.html) attribute to be rendered live in interface builder. Open up the example project (`pod try YOLayout`) and take a look at [DrawableView.m](https://github.com/YOLayout/YOLayout/blob/master/YOLayoutExample/YOLayoutExample/DrawableViews/DrawableView.m) and DrawableView.xib.

## Dependencies

There are none!

## Installation

YOLayout is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "YOLayout"

## License

YOLayout is available under the MIT license. See the LICENSE file for more info.
