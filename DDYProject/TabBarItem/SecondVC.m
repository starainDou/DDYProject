//
//  SecondVC.m
//  DDYProject
//
//  Created by LingTuan on 17/7/21.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import "SecondVC.h"

@interface SecondVC ()

@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [DDYButton customDDYBtn].btnTitleN(@"AirDrop").btnTitleColorN(DDYRGBA(0, 0, 0, 1)).btnFont(DDYFont(13))
                            .btnFrame(0,64,90,20).btnSuperView(self.view).btnAction(self,@selector(airDrop));
}

- (void)airDrop {
    [DDYTools ddy_AirDropShare:@"qrcode.png" currentVC:self];
}

#pragma mark - 控制旋转屏幕
#pragma mark 支持旋转的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
#pragma mark 是否支持自动旋转
- (BOOL)shouldAutorotate
{
    return NO;
}



@end
