//
//  DDYCirCleAnimationView.h
//  FireFly
//
//  Created by LingTuan on 17/9/20.
//  Copyright © 2017年 NAT. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DDYCirCleAnimationView : UIView

@property (nonatomic, strong) UIColor *fillColor;

@property (nonatomic, strong) UIColor *strokeColor;

+ (instancetype)circleViewFrame:(CGRect)frame;

@end
