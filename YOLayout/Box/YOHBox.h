//
//  YOHBox.h
//  YOLayout
//
//  Created by Gabriel on 3/13/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YOBox_IMP.h"

@interface YOHBox : YOBox

+ (YOLayoutBlock)horizontalLayout:(YOBox *)box;

@end

CGSize YOLayoutVHorizontal(YOBox *box, YOLayout *layout, CGSize size);