//
//  DDYWaterFallHeader.m
//  DDYProject
//
//  Created by LingTuan on 17/9/13.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import "DDYWaterFallHeader.h"

@interface DDYWaterFallHeader ()

@property (nonatomic, strong) DDYButton *titleBtn;

@end

@implementation DDYWaterFallHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupContentView];
    }
    return self;
}

- (void)setupContentView {
    _titleBtn = [DDYButton customDDYBtn].btnFrame(10,0,self.ddy_w-20,self.ddy_h).btnSuperView(self);
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleBtn.btnTitleN(title).btnTitleColorN([UIColor blackColor]).btnBgColor([UIColor orangeColor]);
}

@end
