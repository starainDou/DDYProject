//
//  DDYBaseViewController.m
//  NAToken
//
//  Created by LingTuan on 17/7/28.
//  Copyright © 2017年 NAT. All rights reserved.
//

#import "DDYBaseViewController.h"

@interface DDYBaseViewController ()

@property (nonatomic, strong) UIView *navLine;

@end

@implementation DDYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepare];
    [self buildUI];
}

- (void)prepare
{
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.view.backgroundColor = DDYBackColor;

    UIView *backgroundView = [self.navigationController.navigationBar subviews].firstObject;
    for (UIView *view in backgroundView.subviews)
    {
        if ([view isKindOfClass:[UIImageView class]] && view.ddy_h == 0.5)
        {
            _navLine = (UIImageView *)view;
        }
    }
}

- (void)buildUI
{
    
}

- (void)setNavigationBarBottomLineHidden:(BOOL)navigationBarBottomLineHidden
{
    _navigationBarBottomLineHidden = navigationBarBottomLineHidden;
    _navLine.hidden = _navigationBarBottomLineHidden;
}

#pragma mark 导航栏背景透明度设置
- (void)setNavigationBackgroundAlpha:(CGFloat)alpha
{
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:alpha];
}

#pragma mark leftButton
- (void)showLeftBarBtnWithTitle:(NSString *)title img:(UIImage *)img
{
    DDYButton *leftBtn = [DDYButton customDDYBtn].btnAction(self, @selector(leftBtnClick:)).btnW(30).btnH(30);
    if (title) leftBtn.btnTitleN(title).btnFont(DDYFont(15));
    if (img)   leftBtn.btnImageN(img);
    [leftBtn sizeThatFits:CGSizeMake(120, 30)];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}

- (void)showRightBarBtnWithTitle:(NSString *)title img:(UIImage *)img
{
    DDYButton *rightBtn = [DDYButton customDDYBtn].btnAction(self, @selector(rightBtnClick:)).btnW(30).btnH(30);
    if (title) rightBtn.btnTitleN(title).btnFont(DDYFont(15));
    if (img)   rightBtn.btnImageN(img);
    [rightBtn sizeThatFits:CGSizeMake(120, 30)];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

- (void)showBackBarBtnDefault
{
    DDYButton *backBtn = [DDYButton customDDYBtn].btnImgNameN(@"back_black").btnAction(self, @selector(backBtnClick:)).btnW(30).btnH(30);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

#pragma mark - leftButtonTouch
- (void)backBtnClick:(DDYButton *)button
{
    if (![self.navigationController popViewControllerAnimated:YES]) {
        [self dismissViewControllerAnimated:YES completion:^{ }];
    };
}

#pragma mark leftButtonTouch
- (void)leftBtnClick:(DDYButton *)button {
    
}

#pragma mark  rightButtonTouch
- (void)rightBtnClick:(DDYButton *)button {
    
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
