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
    [self prepareSetting];
}

- (void)prepareSetting
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
    DDYButton *backBtn = [DDYButton customDDYBtn].btnAction(self, @selector(backBtnClick:)).btnW(30).btnH(30);
    if (title) {
        backBtn.btnTitleN(title).btnFont(DDYFont(15));
    }
    if (img) {
        backBtn.btnImageN(img);
    }
    [backBtn sizeThatFits:CGSizeMake(120, 30)];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

- (void)showRightBarBtnWithTitle:(NSString *)title img:(UIImage *)img
{
    DDYButton *backBtn = [DDYButton customDDYBtn].btnAction(self, @selector(rightBtnClick:)).btnW(30).btnH(30);
    if (title) {
        backBtn.btnTitleN(title).btnFont(DDYFont(15));
    }
    if (img) {
        backBtn.btnImageN(img);
    }
    [backBtn sizeThatFits:CGSizeMake(120, 30)];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

- (void)showLeftBarBtnDefault
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

#pragma mark - rightButtonTouch
- (void)rightBtnClick:(DDYButton *)button
{
    
}

@end
