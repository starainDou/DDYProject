//
//  DDYButton+DDYLinkBlock.h
//  DDYProject
//
//  Created by LingTuan on 17/7/21.
//  Copyright © 2017年 Starain. All rights reserved.
//
#import "LinkBlockDefine.h"

@interface NSObject (DDYLinkBlock)

////////////////////////////// 链式编程 /////////////////////////////

/** btnFrame(x, y, w, h) = [btn setFrame:CGRectMake(x, y, w, h)] */
@property (nonatomic, copy, readonly) DDYButton *(^btnFrame)(CGFloat x, CGFloat y, CGFloat w,CGFloat h);

/** btnSize(w, h) */
@property (nonatomic, copy, readonly) DDYButton *(^btnSize)(CGFloat w,CGFloat h);

/** btnX(x) */
@property (nonatomic, copy, readonly) DDYButton *(^btnX)(CGFloat x);

/** btnY(y) */
@property (nonatomic, copy, readonly) DDYButton *(^btnY)(CGFloat y);

/** btnW(w) */
@property (nonatomic, copy, readonly) DDYButton *(^btnW)(CGFloat w);

/** btnH(h) */
@property (nonatomic, copy, readonly) DDYButton *(^btnH)(CGFloat h);

/** btnTitleN(title)  =  [btn setTitle:title forState:UIControlStateNormal] */
@property (nonatomic, copy, readonly) DDYButton *(^btnTitleN)(NSString *title);

/** btnTitleS(title)  =  [btn setTitle:title forState:UIControlStateSelected] */
@property (nonatomic, copy, readonly) DDYButton *(^btnTitleS)(NSString *title);

/** btnTitleH(title)  =  [btn setTitle:title forState:UIControlStateHighlighted] */
@property (nonatomic, copy, readonly) DDYButton *(^btnTitleH)(NSString *title);

/** btnTitleColorN(color)  =  [btn setTitleColor:color forState:UIControlStateNormal] */
@property (nonatomic, copy, readonly) DDYButton *(^btnTitleColorN)(UIColor *color);

/** btnTitleColorS(color)  =  [btn setTitleColor:color forState:UIControlStateSelected] */
@property (nonatomic, copy, readonly) DDYButton *(^btnTitleColorS)(UIColor *color);

/** btnTitleColorH(color)  =  [btn setTitleColor:color forState:UIControlStateHighlighted] */
@property (nonatomic, copy, readonly) DDYButton *(^btnTitleColorH)(UIColor *color);

/** btnImageN(image)  =  [btn setImage:image forState:UIControlStateNormal] */
@property (nonatomic, copy, readonly) DDYButton *(^btnImageN)(UIImage *image);

/** btnImageS(image)  =  [btn setImage:image forState:UIControlStateSelected] */
@property (nonatomic, copy, readonly) DDYButton *(^btnImageS)(UIImage *image);

/** btnImageH(image)  =  [btn setImage:image forState:UIControlStateHeighlighted] */
@property (nonatomic, copy, readonly) DDYButton *(^btnImageH)(UIImage *image);

/** btnBgImageN(image)  =  [btn setBackgroundImage:image forState:UIControlStateNormal] */
@property (nonatomic, copy, readonly) DDYButton *(^btnBgImageN)(UIImage *image);

/** btnBgImageS(image)  =  [btn setBackgroundImage:image forState:UIControlStateSelected] */
@property (nonatomic, copy, readonly) DDYButton *(^btnBgImageS)(UIImage *image);

/** btnBgImageH(image)  =  [btn setBackgroundImage:image forState:UIControlStateHeighlighted] */
@property (nonatomic, copy, readonly) DDYButton *(^btnBgImageH)(UIImage *image);

/** btnImageN(imgName)  =  [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal] */
@property (nonatomic, copy, readonly) DDYButton *(^btnImgNameN)(NSString *imgName);

/** btnImageH(imgName)  =  [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateHeighlighted] */
@property (nonatomic, copy, readonly) DDYButton *(^btnImgNameH)(NSString *imgName);

/** btnImageS(imgName)  =  [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateSelected] */
@property (nonatomic, copy, readonly) DDYButton *(^btnImgNameS)(NSString *imgName);

/** btnBgImageN(imgName)  =  [btn setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal] */
@property (nonatomic, copy, readonly) DDYButton *(^btnBgImgNameN)(NSString *imgName);

/** btnBgImageH(imgName)  =  [btn setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateHeighlighted] */
@property (nonatomic, copy, readonly) DDYButton *(^btnBgImgNameH)(NSString *imgName);

/** btnBgImageS(imgName)  =  [btn setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateSelected] */
@property (nonatomic, copy, readonly) DDYButton *(^btnBgImgNameS)(NSString *imgName);

/** btnLayoutStyle(style) */
@property (nonatomic, copy, readonly) DDYButton *(^btnLayoutStyle)(DDYBtnStyle style);

/** btnPadding(padding) */
@property (nonatomic, copy, readonly) DDYButton *(^btnPadding)(CGFloat padding);

/** btnSuperView(superView) */
@property (nonatomic, copy, readonly) DDYButton *(^btnSuperView)(UIView *superView);

/** btnFont(font) */
@property (nonatomic, copy, readonly) DDYButton *(^btnFont)(UIFont *font);

/** btnBgColor(color) */
@property (nonatomic, copy, readonly) DDYButton *(^btnBgColor)(UIColor *color);

/** btnTag(tag) */
@property (nonatomic, copy, readonly) DDYButton *(^btnTag)(NSInteger tag);

/** btnAction(action) */
@property (nonatomic, copy, readonly) DDYButton *(^btnAction)(id target,SEL action);

//- (DDYButton *(^)(UIFont *font))btnFont;

@end
