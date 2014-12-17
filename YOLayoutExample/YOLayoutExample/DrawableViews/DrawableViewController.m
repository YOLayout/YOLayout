//
//  DrawableViewController.m
//  YOLayoutExample
//
//  Created by John Boiles on 12/16/14.
//  Copyright (c) 2014 YOLayout. All rights reserved.
//

#import "DrawableViewController.h"
#import "DrawableView.h"
#import "GridView.h"

@interface DrawableViewController ()

@end

@implementation DrawableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Drawable View Example";
}

- (void)loadView {
    self.edgesForExtendedLayout = UIRectEdgeNone;

    // For simple views that have static content, but dynamic layouts, you don't even have to subclass YOView, you can create the view and layout inline.
    YOView *view = [[YOView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"The following view draws 10 logos in drawRect: based on the available width. Try rotating into landscape and see how the grid changes";
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0];
    [view addSubview:label];

    DrawableView *drawableView = [[DrawableView alloc] init];
    drawableView.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0];
    [view addSubview:drawableView];

    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"The following view's subviews are part of the view hierarchy but are otherwise laid out exactly like the above view";
    label2.numberOfLines = 0;
    label2.lineBreakMode = NSLineBreakByWordWrapping;
    label2.textAlignment = NSTextAlignmentCenter;
    label2.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0];
    [view addSubview:label2];

    GridView *gridView = [[GridView alloc] init];
    [view addSubview:gridView];
    
    view.layout = [YOLayout layoutWithLayoutBlock:^CGSize(id<YOLayout> layout, CGSize size) {
        UIEdgeInsets insets = UIEdgeInsetsMake(10, 10, 10, 10);
        CGFloat x = insets.left;
        CGFloat y = insets.right;
        CGFloat contentWidth = size.width - insets.left - insets.right;

        y += [layout setFrame:CGRectMake(x, y, contentWidth, 1000) view:label options:YOLayoutOptionsSizeToFit | YOLayoutOptionsCenterHorizontal].size.height + 10;

        // Size the view to fit, and center it horizontally
        y += [layout setFrame:CGRectMake(x, y, contentWidth, 0) view:drawableView options:YOLayoutOptionsSizeToFit | YOLayoutOptionsCenterHorizontal | YOLayoutOptionsVariableWidth].size.height + 10;

        y += [layout setFrame:CGRectMake(x, y, contentWidth, 1000) view:label2 options:YOLayoutOptionsSizeToFit | YOLayoutOptionsCenterHorizontal].size.height + 10;

        [layout setFrame:CGRectMake(x, y, contentWidth, 0) view:gridView options:YOLayoutOptionsSizeToFit | YOLayoutOptionsCenterHorizontal | YOLayoutOptionsVariableWidth];

        return size;
    }];

    self.view = view;
}

@end
