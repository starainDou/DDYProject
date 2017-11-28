//
//  DDYGroupHeaderVC.m
//  DDYProject
//
//  Created by LingTuan on 17/11/9.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import "DDYGroupHeaderVC.h"

@interface DDYGroupHeaderVC ()

@end

@implementation DDYGroupHeaderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DDY_White;
    
    CGFloat headerWH = 150;
    
//    NSArray *array1 = @[[UIImage imageNamed:@"0"]];
//    NSArray *array2 = @[[UIImage imageNamed:@"0"],[UIImage imageNamed:@"1"]];
//    NSArray *array3 = @[[UIImage imageNamed:@"0"],[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"]];
//    NSArray *array4 = @[[UIImage imageNamed:@"0"],[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"]];
    NSArray *array5 = @[[UIImage imageNamed:@"0"],[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"],[UIImage imageNamed:@"4"]];
//
//    DDYGroupHeader *header1 = [DDYGroupHeader headerWithHeaderWH:headerWH];
//    header1.images = array5;
//    header1.center = CGPointMake(self.view.ddy_w/2, self.view.ddy_h/2);
//    header1.backgroundColor = DDY_LightGray;
//    [self.view addSubview:header1];
    
    DDYHeader *header5 = [DDYHeader headerWithHeaderWH:headerWH];
    header5.imgArray = array5;
    header5.urlArray = @[@"0", @"1", @"2", @"3", @"4"];
    header5.center = CGPointMake(self.view.ddy_w/2-80, self.view.ddy_h/2-160);
    header5.backgroundColor = DDY_LightGray;
    [self.view addSubview:header5];
    
    DDYHeader *header4 = [DDYHeader headerWithHeaderWH:headerWH];
    header4.imgArray = array5;
    header4.urlArray = @[@"0", @"1", @"2", @"3"];
    header4.center = CGPointMake(self.view.ddy_w/2+80, self.view.ddy_h/2-160);
    header4.backgroundColor = DDY_LightGray;
    [self.view addSubview:header4];
    
    
    DDYHeader *header3 = [DDYHeader headerWithHeaderWH:headerWH];
    header3.imgArray = array5;
    header3.urlArray = @[@"0", @"1", @"2"];
    header3.center = CGPointMake(self.view.ddy_w/2, self.view.ddy_h/2);
    header3.backgroundColor = DDY_LightGray;
    [self.view addSubview:header3];
    
    DDYHeader *header2 = [DDYHeader headerWithHeaderWH:headerWH];
    header2.imgArray = array5;
    header2.urlArray = @[@"0", @"1"];
    header2.center = CGPointMake(self.view.ddy_w/2-80, self.view.ddy_h/2+160);
    header2.backgroundColor = DDY_LightGray;
    [self.view addSubview:header2];
    
    DDYHeader *header1 = [DDYHeader headerWithHeaderWH:headerWH];
    header1.imgArray = @[@"0"];
    header1.urlArray = @[@"http://upload-images.jianshu.io/upload_images/1465510-5a5b07561e664349.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"];
    header1.center = CGPointMake(self.view.ddy_w/2+80, self.view.ddy_h/2+160);
    header1.backgroundColor = DDY_LightGray;
    [self.view addSubview:header1];
    
}

@end
