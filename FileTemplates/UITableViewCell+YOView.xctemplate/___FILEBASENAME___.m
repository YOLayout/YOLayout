//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

#import "___FILEBASENAME___.h"

@interface ___FILEBASENAMEASIDENTIFIER___View ()
@end

@implementation ___FILEBASENAMEASIDENTIFIER___View

- (void)viewInit {

    // Initialize subviews here

    __weak typeof(self) weakSelf = self;
    self.layout = [YOLayout layoutWithLayoutBlock:^CGSize(id<YOLayout> layout, CGSize size) {

        // Define the layout here

        return size;
    }];
}

@end


@interface ___FILEBASENAMEASIDENTIFIER___ ()
@property ___FILEBASENAMEASIDENTIFIER___View *view;
@end

@implementation ___FILEBASENAMEASIDENTIFIER___

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.view = [[___FILEBASENAMEASIDENTIFIER___View alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:self.view];
        self.contentView.autoresizesSubviews = YES;
        self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return [self.view sizeThatFits:size];
}

@end
