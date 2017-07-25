//
//  DDYTabBar.h
//  DDYProject
//
//  Created by Rain Dou on 15/5/18.
//  Copyright © 2015年 634778311 All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDYTabBar;

@protocol DDYTabBarDelegate <NSObject, UITabBarDelegate>

@optional

- (void)tabBarDidPlusBtn:(DDYTabBar *)tabBar;

@end

@interface DDYTabBar : UITabBar

@property (nonatomic, weak) id<DDYTabBarDelegate> delegate;

@end
