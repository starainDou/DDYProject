//
//  FourthVC.m
//  DDYProject
//
//  Created by LingTuan on 17/7/21.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import "FourthVC.h"

@interface FourthVC ()

@end

@implementation FourthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSURL *url = [NSURL URLWithString:@"http://7xvqzv.com1.z0.glb.clouddn.com/attach-8b9fa70d-4932-4278-a4d4-6071317a837c_0.png"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [UIImage imageWithData:data];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:imgView];
    imgView.image = img;
    DDYInfoLog(@"%@",img);
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
