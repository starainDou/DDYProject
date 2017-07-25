
//
//  DDYNavigationController.m
//  DDYProject
//
//  Created by Rain Dou on 15/5/18.
//  Copyright © 2015年 634778311 All rights reserved.
//

#import "DDYNavigationController.h"

@interface DDYNavigationController ()

@end

@implementation DDYNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 为0则代表进入二级界面，需要设置返回样式
    if (self.viewControllers.count > 0) {
        
        /* 左按钮 */
        UIButton *backBtn = [[UIButton alloc] init];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        
        [backBtn setImage:[UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(20, 40)] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(20, 40)] forState:UIControlStateHighlighted];
        
        [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        backBtn.ddy_size = CGSizeMake(60, 30);
        
        backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        
        // push后页面隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 如果把判断写到前面，当单个页面在自己的控制器中修改时又被覆盖掉，导致更换失败
    [super pushViewController:viewController animated:animated];
}

#pragma mark - leftButtonTouch
- (void)backBtnClick:(UIButton *)button
{
    [self popViewControllerAnimated:YES];
}

@end
