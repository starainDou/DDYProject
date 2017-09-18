//
//  FilterTestVC.m
//  DDYProject
//
//  Created by LingTuan on 17/8/23.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import "FilterTestVC.h"

@interface FilterTestVC ()

@end

@implementation FilterTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = DDYBackColor;
    
    //可以打印出所有的过滤器以及支持的属性
    NSArray *filters = [CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    for (NSString *filterName in filters) {
//        CIFilter *filter = [CIFilter filterWithName:filterName];
//        NSLog(@"%@,%@",filterName,[filter attributes]);
        NSLog(@"%@",filterName);
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.img];
    imageView.frame = self.view.bounds;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
}

- (UIImage *)img {
    if (!_img) {
        
        //创建基于GPU的CIContext
        CIContext *context = [CIContext contextWithOptions:nil];
        
        //创建过滤器
        CIFilter *filter = [CIFilter filterWithName:@"CIPixellate"];
        
        //创建CIImage
        //    CIImage *sourceImage = [CIImage imageWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"FilterImg" ofType:@"jpg"]]];
        CIImage *sourceImage = [CIImage imageWithCGImage:[UIImage imageNamed:@"FilterImg.jpg"].CGImage];
        
        //将CIImage设为源图片
        [filter setValue:sourceImage forKey:@"inputImage"];
        
        //设置过滤参数(像素大小)
        [filter setValue:@5 forKey:@"inputScale"];
        
        //得到输出图片
        CIImage *outputImage = [filter outputImage];
        
        CGImageRef cgImage= [context createCGImage:outputImage fromRect:[UIScreen mainScreen].bounds];
        _img = [UIImage imageWithCGImage:cgImage];
        
        //调用了create创建，需要release
        CGImageRelease(cgImage);
    }
    return _img;
}

@end
