//
//  YONSLabel.m
//  YOLayoutExample
//
//  Created by Gabriel on 1/20/15.
//  Copyright (c) 2015 YOLayout. All rights reserved.
//

#import "YONSLabel.h"

@interface YONSLabel ()
@property NSTextView *textView;
@end

@implementation YONSLabel

- (void)viewInit {
  [super viewInit];
  _textView = [[NSTextView alloc] init];
  _textView.backgroundColor = NSColor.clearColor;
  _textView.editable = NO;
  _textView.selectable = NO;
  _textView.textContainerInset = NSMakeSize(0, 0);
  _textView.textContainer.lineFragmentPadding = 0;
  [self addSubview:_textView];

  YOSelf yself = self;
  self.viewLayout = [YOLayout layoutWithLayoutBlock:^(YOLayout *layout, CGSize size) {
    CGSize textSize = [YONSLabel sizeThatFits:size attributedString:yself.textView.attributedString];
    [layout setFrame:CGRectIntegral(CGRectMake(0, size.height/2.0 - textSize.height/2.0, size.width, textSize.height + 20)) view:yself.textView];
    return size;
  }];
}

- (CGSize)sizeThatFits:(CGSize)size {
  return [YONSLabel sizeThatFits:size attributedString:_textView.attributedString];
}

- (void)setText:(NSString *)text font:(NSFont *)font color:(NSColor *)color alignment:(NSTextAlignment)alignment {
  NSParameterAssert(font);
  NSParameterAssert(color);
  if (!text) text = @"";
  NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
  NSDictionary *attributes = @{NSForegroundColorAttributeName:color, NSFontAttributeName:font};
  [str setAttributes:attributes range:NSMakeRange(0, str.length)];

  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  paragraphStyle.alignment = alignment;
  [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
  [self setAttributedText:str];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
  _attributedText = attributedText;
  if (_attributedText) {
    NSAssert(_textView.textStorage, @"No text storage");
    [_textView.textStorage setAttributedString:attributedText];
  }
  [self setNeedsLayout];
}

+ (CGSize)sizeThatFits:(CGSize)size attributedString:(NSAttributedString *)attributedString {
  if (size.height == 0) size.height = CGFLOAT_MAX;
  if (size.width == 0) size.width = CGFLOAT_MAX;
  NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:attributedString];
  NSTextContainer *textContainer = [[NSTextContainer alloc] initWithContainerSize:size];
  [textContainer setLineFragmentPadding:0.0];
  NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
  [layoutManager addTextContainer:textContainer];
  [textStorage addLayoutManager:layoutManager];

  // Force layout
  (void)[layoutManager glyphRangeForTextContainer:textContainer];
  NSRect rect = [layoutManager usedRectForTextContainer:textContainer];

  //NSRect rect = [attributedString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin];

  return CGRectIntegral(rect).size;
}

@end