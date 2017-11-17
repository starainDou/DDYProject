//
//  DDYHeader.h
//  DDYProject
//
//  Created by LingTuan on 17/11/16.
//  Copyright © 2017年 Starain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDYHeader : UIView

@property (nonatomic, strong) NSArray *imageURLArray;

+ (instancetype)headerWithHeaderWH:(CGFloat)headerWH;

@end
