//
//  DDYTextView.m
//  DDYProject
//
//  Created by LingTuan on 17/7/27.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import "DDYTextView.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface DDYTextView ()

@property (nonatomic, strong) UILabel *placeHolderLabel;

@end


@implementation DDYTextView

@synthesize placeholder = _placeholder;
@synthesize placeholderTextColor = _placeholderTextColor;

+ (instancetype)textView
{
    return [[self alloc] init];
}

+ (instancetype)textViewPlaceholder:(NSString *)placeholder font:(UIFont *)font
{
    return [[self alloc] initWithPlaceholder:placeholder font:font frame:CGRectZero];
}

+ (instancetype)textViewPlaceholder:(NSString *)placeholder font:(UIFont *)font frame:(CGRect)frame
{
    return [[self alloc] initWithPlaceholder:placeholder font:font frame:frame];
}

- (instancetype)initWithPlaceholder:(NSString *)placeholder font:(UIFont *)font frame:(CGRect)frame
{
    if (self = [self initWithFrame:frame])
    {
        self.placeholder = placeholder;
        self.placeholderTextColor = [UIColor lightGrayColor];
        self.font = font;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        // layoutManager(NSLayoutManager)的是否非连续布局属性，默认YES，设置为NO就不会再自己重置滑动了。
        self.layoutManager.allowsNonContiguousLayout = NO;
        // 如果存在占位字符则默认浅灰色
        self.placeholderTextColor = [UIColor lightGrayColor];
        
        self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
    }
    return self;
}

- (UILabel *)placeHolderLabel
{
    if (!_placeHolderLabel)
    {
        _placeHolderLabel = [[UILabel alloc] init];
        
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList(NSClassFromString(@"UITextView"), &count);
        for(int i =0; i < count; i ++)
        {
            NSString *ivarName = [NSString stringWithCString:ivar_getName(ivars[i]) encoding:NSUTF8StringEncoding];
            if ([ivarName isEqualToString:@"_placeholderLabel"])
            {
                _placeHolderLabel.numberOfLines = 0;
                _placeHolderLabel.font = self.font;
                _placeHolderLabel.ddy_x = 5;
                _placeHolderLabel.ddy_y = 8;
                _placeHolderLabel.textAlignment = self.textAlignment;
                [self addSubview:_placeHolderLabel];
                [self setValue:_placeHolderLabel forKey:@"_placeholderLabel"];
            }
        }
    }
    return _placeHolderLabel;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.placeHolderLabel.text = placeholder;
    [self setNeedsDisplay];
}

- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor
{
    _placeholderTextColor = placeholderTextColor;
    [self setNeedsDisplay];
}

- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset
{
    [super setTextContainerInset:textContainerInset];
    [self setNeedsDisplay];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setNeedsDisplay];
}

- (void)changePlaceholderLocation
{
    if (!self.font) {
        DDYInfoLog(@"请先设置DDYTextView对象的font");
        self.font = DDYFont(12);
    }
    _placeHolderLabel.textColor = self.placeholderTextColor;
    _placeHolderLabel.font = self.font;
    _placeHolderLabel.ddy_x = self.textContainerInset.left;
    _placeHolderLabel.ddy_w = self.ddy_w - self.textContainerInset.left - self.textContainerInset.right;
    _placeHolderLabel.ddy_y = self.textContainerInset.top;
    _placeHolderLabel.ddy_h = self.ddy_h - self.textContainerInset.top - self.textContainerInset.bottom;
    [_placeHolderLabel sizeToFit];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self changePlaceholderLocation];
}

#pragma mark 文字size
- (CGSize)textSize {
    // 边框margin
    CGFloat boardMargin = self.contentInset.left
    + self.contentInset.right
    + self.textContainerInset.left
    + self.textContainerInset.right
    + self.textContainer.lineFragmentPadding
    + self.textContainer.lineFragmentPadding;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = self.textContainer.lineBreakMode;
    
    return [self.text boundingRectWithSize:CGSizeMake(self.ddy_w-boardMargin, MAXFLOAT)
                                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                attributes:@{NSFontAttributeName:self.font, NSParagraphStyleAttributeName:paragraphStyle}
                                   context:nil].size;
}

#pragma mark 调整高宽适应规定高度
- (void)heightFitMinHeight:(CGFloat)minH maxHeight:(CGFloat)maxH {
    // 边框margin
    CGFloat boardMargin = self.contentInset.top + self.contentInset.bottom + self.textContainerInset.top + self.textContainerInset.bottom;
    self.scrollEnabled = NO;
    if (self.textSize.height+boardMargin < minH) {
        self.ddy_h = minH;
    } else if (self.textSize.height+boardMargin > maxH) {
        self.ddy_h = maxH;
        self.scrollEnabled = YES;
    } else {
        self.ddy_h = ceilf(self.textSize.height+boardMargin);
    }
}

#pragma mark - UI层级调试时出现 -[UITextView _firstBaselineOffsetFromTop] only valid when using auto layout
- (void)_firstBaselineOffsetFromTop {}
- (void)_baselineOffsetFromBottom {}

@end
