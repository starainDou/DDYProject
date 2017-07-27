//
//  TextViewTestVC.m
//  DDYProject
//
//  Created by LingTuan on 17/7/27.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import "TextViewTestVC.h"
#import "DDYTextView.h"

@interface TextViewTestVC ()

@end

@implementation TextViewTestVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepare];
    [self setupTextView];
}

- (void)prepare
{
    // 64当起点布局
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = DDYColor(245, 245, 245, 1);
}

- (void)setupTextView
{
    DDYTextView *textView1 = [DDYTextView textView];
    textView1.backgroundColor = [UIColor whiteColor];
    textView1.font = DDYFont(12);
    textView1.placeholder = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
    textView1.frame = CGRectMake(0, 10, DDYSCREENW, 100);
    textView1.textContainerInset = UIEdgeInsetsMake(10, 20, 10, 20);
    [self.view addSubview:textView1];
    
    
    DDYTextView *textView2 = [DDYTextView textViewPlaceholder:@"我是占位的大哥" font:DDYFont(12) frame:CGRectMake(0, 120, DDYSCREENW, 100)];
    textView2.backgroundColor = [UIColor whiteColor];
    textView2.placeholderTextColor = [UIColor lightGrayColor];
    [self.view addSubview:textView2];
}


@end
