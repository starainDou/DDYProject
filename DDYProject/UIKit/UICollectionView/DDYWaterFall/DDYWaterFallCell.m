//
//  DDYWaterFallCell.m
//  DDYProject
//
//  Created by Rain Dou on 15/5/18.
//  Copyright © 2015年 634778311 All rights reserved.
//

#import "DDYWaterFallCell.h"

@interface DDYWaterFallCell ()

@property (nonatomic, strong) DDYButton *button;

@end

@implementation DDYWaterFallCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _button = [DDYButton customDDYBtn].btnBgColor([UIColor lightGrayColor]).btnTitleColorN([UIColor whiteColor]);
    }
    return self;
}

- (void)loadTitle:(NSString *)title {
    DDYBorderRadius(self, 0, 1, DDYRGBA(0, 0, 0, 0.2));
    _button.btnTitleN(title).btnFont(DDYFont(14)).btnFrame(0,0,self.ddy_w,self.ddy_h).btnSuperView(self);
}

@end
