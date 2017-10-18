//
//  BtnTestVC.m
//  DDYProject
//
//  Created by LingTuan on 17/7/21.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import "BtnTestVC.h"

#define  kDegreesToRadians(degrees)  ((3.14159265359 * degrees)/ 180)

@interface BtnTestVC ()

@end

@implementation BtnTestVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepare];
    [self setupButton];
}

- (void)prepare
{
    // 64当起点布局
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = DDYRGBA(245, 245, 245, 1);
}

- (void)setupButton
{
    // 链式编程 继承方式
    [DDYButton customDDYBtn].btnFrame(10, 10, 60, 80)
                            .btnFont(DDYFont(12))
                            .btnTitleN(@"上图下文")
                            .btnTitleColorN([UIColor blueColor])
                            .btnImageN([UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(20, 20)])
                            .btnLayoutStyle(DDYBtnStyleImgTop)
                            .btnPadding(5)
                            .btnSuperView(self.view);
    
    // 原生编程 继承方式
    DDYButton *button = ({
        DDYButton *btn = [DDYButton customDDYBtn];
        btn.frame = CGRectMake(80, 10, 60, 80);
        btn.titleLabel.font = DDYFont(12);
        [btn setTitle:@"下图上文" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(20, 20)] forState:UIControlStateNormal];
        btn.btnStyle = DDYBtnStyleImgDown;
        btn.padding = 5;
        btn;
    });
    [self.view addSubview:button];
    
    // 原生编程 分类方式
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(150, 10, 85, 80);
    btn.titleLabel.font = DDYFont(12);
    [btn setTitle:@"左文右图" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(20, 20)] forState:UIControlStateNormal];
    [btn DDYStyle:DDYStyleImgRight padding:5];
    [self.view addSubview:btn];
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {

    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"Aciton1" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Aciton1");
    }];
    
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"Aciton2" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Aciton2");
    }];
    
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"Aciton3" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Aciton3");
    }];
    
    NSArray *actions = @[action1,action2,action3];
    
    return actions;
}

@end
