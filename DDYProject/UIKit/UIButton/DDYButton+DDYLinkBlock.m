//
//  DDYButton+DDYLinkBlock.m
//  DDYProject
//
//  Created by LingTuan on 17/7/21.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import "DDYButton+DDYLinkBlock.h"

@implementation DDYButton (DDYLinkBlock)

- (DDYButton *(^)(CGFloat, CGFloat, CGFloat, CGFloat))btnFrame
{
    return ^id(CGFloat x,CGFloat y, CGFloat w, CGFloat h) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnFrame, x, y, w, h)
        _self.frame = CGRectMake(x, y, w, h);
        return _self;
    };
}

- (DDYButton *(^)(CGFloat, CGFloat))btnSize
{
    return ^id(CGFloat w, CGFloat h) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnSize, w, h)
        _self.ddy_size = CGSizeMake(w, h);
        return _self;
    };
}

- (DDYButton *(^)(CGFloat))btnX
{
    return ^id(CGFloat x) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnX, x)
        _self.ddy_x = x;
        return _self;
    };
}

- (DDYButton *(^)(CGFloat))btnY
{
    return ^id(CGFloat y) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnY, y)
        _self.ddy_y = y;
        return _self;
    };
}

- (DDYButton *(^)(CGFloat))btnW
{
    return ^id(CGFloat w) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnW, w)
        _self.ddy_w = w;
        return _self;
    };
}

- (DDYButton *(^)(CGFloat))btnH
{
    return ^id(CGFloat h) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnH, h)
        _self.ddy_h = h;
        return _self;
    };
}

- (DDYButton *(^)(NSString *))btnTitleN
{
    return ^id(NSString *title) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnTitleN, title)
        [_self setTitle:title forState:UIControlStateNormal];
        return _self;
    };
}

- (DDYButton *(^)(NSString *))btnTitleS
{
    return ^id(NSString *title) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnTitleS, title)
        [_self setTitle:title forState:UIControlStateSelected];
        return _self;
    };
}

- (DDYButton *(^)(NSString *))btnTitleH
{
    return ^id(NSString *title) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnTitleH, title)
        [_self setTitle:title forState:UIControlStateHighlighted];
        return _self;
    };
}

- (DDYButton *(^)(UIColor *))btnTitleColorN
{
    return ^id(UIColor *color) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnTitleColorN, color)
        [_self setTitleColor:color forState:UIControlStateNormal];
        return _self;
    };
}

- (DDYButton *(^)(UIColor *))btnTitleColorS
{
    return ^id(UIColor *color) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnTitleColorS, color)
        [_self setTitleColor:color forState:UIControlStateSelected];
        return _self;
    };
}

- (DDYButton *(^)(UIColor *))btnTitleColorH
{
    return ^id(UIColor *color) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnTitleColorH, color)
        [_self setTitleColor:color forState:UIControlStateHighlighted];
        return _self;
    };
}

- (DDYButton *(^)(UIImage *))btnImageN
{
    return ^id(UIImage *image) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnImageN, image)
        [_self setImage:image forState:UIControlStateNormal];
        return _self;
    };
}

- (DDYButton *(^)(UIImage *))btnImageS
{
    return ^id(UIImage *image) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnImageS, image)
        [_self setImage:image forState:UIControlStateSelected];
        return _self;
    };
}

- (DDYButton *(^)(UIImage *))btnImageH
{
    return ^id(UIImage *image) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnImageH, image)
        [_self setImage:image forState:UIControlStateHighlighted];
        return _self;
    };
}

- (DDYButton *(^)(UIImage *))btnBgImageN
{
    return ^id(UIImage *image) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnBgImageN, image)
        [_self setBackgroundImage:image forState:UIControlStateNormal];
        return _self;
    };
}

- (DDYButton *(^)(UIImage *))btnBgImageS
{
    return ^id(UIImage *image) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnBgImageS, image)
        [_self setBackgroundImage:image forState:UIControlStateSelected];
        return _self;
    };
}

- (DDYButton *(^)(UIImage *))btnBgImageH
{
    return ^id(UIImage *image) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnBgImageH, image)
        [_self setBackgroundImage:image forState:UIControlStateHighlighted];
        return _self;
    };
}

- (DDYButton *(^)(NSString *))btnImgNameN
{
    return ^id(NSString *imgName) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnImgNameN, imgName)
        [_self setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        return _self;
    };
}

- (DDYButton *(^)(NSString *))btnImgNameS
{
    return ^id(NSString *imgName) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnImgNameS, imgName)
        [_self setImage:[UIImage imageNamed:imgName] forState:UIControlStateSelected];
        return _self;
    };
}

- (DDYButton *(^)(NSString *))btnImgNameH
{
    return ^id(NSString *imgName) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnImgNameH, imgName)
        [_self setImage:[UIImage imageNamed:imgName] forState:UIControlStateHighlighted];
        return _self;
    };
}

- (DDYButton *(^)(NSString *))btnBgImgNameN
{
    return ^id(NSString *imgName) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnBgImgNameN, imgName)
        [_self setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        return _self;
    };
}

- (DDYButton *(^)(NSString *))btnBgImgNameS
{
    return ^id(NSString *imgName) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnBgImgNameS, imgName)
        [_self setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateSelected];
        return _self;
    };
}

- (DDYButton *(^)(NSString *))btnBgImgNameH
{
    return ^id(NSString *imgName) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnBgImgNameH, imgName)
        [_self setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateHighlighted];
        return _self;
    };
}

- (DDYButton *(^)(DDYBtnStyle))btnLayoutStyle
{
    return ^id(DDYBtnStyle style) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnLayoutStyle, style)
        _self.btnStyle = style;
        return _self;
    };
}

- (DDYButton *(^)(CGFloat))btnPadding
{
    return ^id(CGFloat padding) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnPadding, padding)
        _self.padding = padding;
        return _self;
    };
}

- (DDYButton *(^)(UIView *))btnSuperView
{
    return ^id(UIView *superView) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnSuperView, superView)
        [superView addSubview:_self];
        return _self;
    };
}

- (DDYButton *(^)(UIFont *))btnFont
{
    return ^id(UIFont *font) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnFont, font)
        _self.titleLabel.font = font;
        return _self;
    };
}

- (DDYButton *(^)(UIColor *))btnBgColor
{
    return ^id(UIColor *color) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnBgColor, color)
        _self.backgroundColor = color;
        return _self;
    };
}

- (DDYButton *(^)(NSInteger))btnTag
{
    return ^id(NSInteger tag) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnTag, tag)
        _self.tag = tag;
        return _self;
    };
}

- (DDYButton *(^)(id, SEL))btnAction
{
    return ^id(id target,SEL action) {
        LinkHandle_REF(DDYButton)
        LinkGroupHandle_REF(btnAction, target, action)
        [_self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        return _self;
    };
}

@end
