//
//  DDYButton+LinkLock.h
//  DDYProject
//
//  Created by LingTuan on 17/7/21.
//  Copyright © 2017年 Starain. All rights reserved.
//
#import "LinkBlockDefine.h"
#import "DDYButton.h"

@interface NSObject (LinkLock)

////////////////////////////// 链式编程 /////////////////////////////

LBDeclare DDYButton *(^btnFrame)(CGFloat x, CGFloat y, CGFloat w,CGFloat h);
LBDeclare DDYButton *(^btnX)(CGFloat x);
LBDeclare DDYButton *(^btnY)(CGFloat y);
LBDeclare DDYButton *(^btnW)(CGFloat w);
LBDeclare DDYButton *(^btnH)(CGFloat h);
LBDeclare DDYButton *(^btnTitleN)(NSString *title);
LBDeclare DDYButton *(^btnTitleS)(NSString *title);
LBDeclare DDYButton *(^btnTitleH)(NSString *title);
LBDeclare DDYButton *(^btnTitleColorN)(UIColor *color);
LBDeclare DDYButton *(^btnTitleColorS)(UIColor *color);
LBDeclare DDYButton *(^btnTitleColorH)(UIColor *color);
LBDeclare DDYButton *(^btnImageN)(UIImage *image);
LBDeclare DDYButton *(^btnImageS)(UIImage *image);
LBDeclare DDYButton *(^btnImageH)(UIImage *image);
LBDeclare DDYButton *(^btnImgNameN)(NSString *imgName);
LBDeclare DDYButton *(^btnImgNameS)(NSString *imgName);
LBDeclare DDYButton *(^btnImgNameH)(NSString *imgName);
LBDeclare DDYButton *(^btnLayoutStyle)(DDYBtnStyle style);
LBDeclare DDYButton *(^btnPadding)(CGFloat padding);
LBDeclare DDYButton *(^btnSuperView)(UIView *superView);
LBDeclare DDYButton *(^btnFont)(UIFont *font);
LBDeclare DDYButton *(^btnBgColor)(UIColor *color);

//- (DDYButton *(^)(UIFont *font))btnFont;

@end
